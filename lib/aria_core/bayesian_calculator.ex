# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule AriaCore.BayesianCalculator do
  @moduledoc """
  Bayesian probability calculator with sliding window support.

  This module implements Bayesian inference for tracking execution outcomes and
  calculating success probabilities. It uses a Beta distribution with sliding window
  support to maintain recent execution history and provide probabilistic estimates.

  ## Overview

  The calculator maintains execution statistics using a sliding window approach,
  where only the most recent N executions are considered for probability calculations.
  This prevents old data from unduly influencing current probability estimates.

  ## Use Cases

  - **Plan Success Tracking**: Monitor planning algorithm success rates
  - **Action Reliability**: Track action execution success probabilities
  - **Adaptive Planning**: Adjust planning strategies based on historical performance

  ## Mathematical Foundation

  Uses Beta(α, β) distribution where:
  - α = successes + 1 (prior belief in success)
  - β = failures + 1 (prior belief in failure)
  - Posterior mean = α / (α + β)

  ## Examples

  ```elixir
  # Calculate probability from 8 successes, 2 failures, window size 20
  prob = BayesianCalculator.calculate_probability(8, 2, 20)
  # => 0.8

  # Update with new success
  {new_successes, new_failures} = BayesianCalculator.update_outcome(8, 2, :success, 20)
  # => {9, 2}

  # Get credible interval
  {lower, upper} = BayesianCalculator.credible_interval(8, 2, 20, 0.95)
  # => {0.65, 0.95}
  ```
  """

  @doc """
  Calculate success probability from execution history using sliding window.

  Args:
    - successes: count of successful executions
    - failures: count of failed executions
    - window_size: size of sliding window (only recent N executions count)

  Returns:
    - probability: float between 0.0 and 1.0
  """
  def calculate_probability(successes, failures, window_size \\ 20) do
    total = successes + failures

    cond do
      total == 0 ->
        0.5  # Default prior when no data
      total <= window_size ->
        successes / total
      true ->
        # Apply sliding window: only count recent executions
        recent_total = window_size
        # Proportionally scale successes to window
        recent_successes = round(successes * window_size / total)
        recent_successes / recent_total
    end
  end

  @doc """
  Update execution history with new outcome.
  Maintains sliding window by dropping oldest if needed.

  Args:
    - successes: current success count
    - failures: current failure count
    - outcome: :success or :failure
    - window_size: size of sliding window

  Returns:
    - {new_successes, new_failures}
  """
  def update_outcome(successes, failures, outcome, window_size \\ 20) do
    total = successes + failures

    case outcome do
      :success ->
        new_successes = successes + 1
        new_failures = failures

        if new_successes + new_failures > window_size do
          # Drop oldest: scale down proportionally
          scale = window_size / (total + 1)
          {round(new_successes * scale), round(new_failures * scale)}
        else
          {new_successes, new_failures}
        end

      :failure ->
        new_successes = successes
        new_failures = failures + 1

        if new_successes + new_failures > window_size do
          # Drop oldest: scale down proportionally
          scale = window_size / (total + 1)
          {round(new_successes * scale), round(new_failures * scale)}
        else
          {new_successes, new_failures}
        end
    end
  end

  @doc """
  Get Beta distribution parameters for Bayesian inference.
  Returns {alpha, beta} for Beta distribution.
  """
  def beta_parameters(successes, failures, window_size \\ 20) do
    # Start with Beta(1,1) prior, add observed data
    alpha = 1 + successes
    beta = 1 + failures

    # Apply window constraint
    total = successes + failures
    if total > window_size do
      scale = window_size / total
      {round(alpha * scale), round(beta * scale)}
    else
      {alpha, beta}
    end
  end

  @doc """
  Get posterior distribution parameters (alpha, beta) for Bayesian inference.
  The posterior probability IS the Beta distribution - no confidence interval needed.
  In Bayesian inference, the entire distribution represents uncertainty.
  """
  def posterior_distribution(successes, failures, window_size \\ 20) do
    beta_parameters(successes, failures, window_size)
  end

  @doc """
  Calculate credible interval from Beta distribution.
  This represents the range where the true probability likely falls,
  based on the posterior distribution from observed data.
  """
  def credible_interval(successes, failures, window_size \\ 20, credibility \\ 0.95) do
    {alpha, beta} = beta_parameters(successes, failures, window_size)

    # For Beta distribution, use approximation
    p = alpha / (alpha + beta)
    variance = (alpha * beta) / ((alpha + beta) ** 2 * (alpha + beta + 1))
    std_dev = :math.sqrt(variance)

    # Calculate z-score for given credibility level (approximation for normal distribution)
    z = case credibility do
      0.90 -> 1.645
      0.95 -> 1.96
      0.99 -> 2.576
      _ -> 1.96  # Default to 95%
    end

    lower = max(0.0, p - z * std_dev)
    upper = min(1.0, p + z * std_dev)

    {lower, upper}
  end
end
