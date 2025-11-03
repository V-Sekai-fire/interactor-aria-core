# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule AriaCore do
  @moduledoc """
  The external API for the `AriaCore` application.

  AriaCore provides foundational utilities and shared functionality used across
  the Aria ecosystem. This includes Bayesian probability calculations, UUID generation,
  data validation, and common helper functions.

  ## Core Components

  - **BayesianCalculator**: Probabilistic reasoning with sliding window support
  - **UUID**: RFC 9562 UUIDv7 generation utilities
  - **Validator**: Common validation functions for Ecto changesets

  ## Usage

  ### Bayesian Probability

  ```elixir
  # Calculate success probability from execution history
  probability = AriaCore.BayesianCalculator.calculate_probability(8, 2, 20)
  # => 0.8
  ```

  ### UUID Generation

  ```elixir
  # Generate a UUIDv7
  uuid = AriaCore.UUID.generate_v7()
  ```

  ### Validation

  ```elixir
  # Validate UUIDv7 in Ecto changeset
  changeset
  |> AriaCore.Validator.validate_uuid_v7(:id)
  ```
  """

  @doc """
  Returns a greeting.

  ## Examples

      iex> AriaCore.hello()
      :world
  """
  def hello do
    :world
  end
end
