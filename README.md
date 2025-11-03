# AriaCore

**⚠️ ALPHA • Research Code • Not Production Ready ⚠️**

> **This module is part of the Aria Character Core research project. Most features are experimental, incomplete, or non-functional. See the root [README.md](../../README.md) for current project status and limitations.**

AriaCore provides foundational utilities and shared functionality used across the Aria ecosystem. This includes Bayesian probability calculations, UUID generation, data validation, and common helper functions.

## Status

| Feature                | Status      | Notes                                      |
|------------------------|------------|--------------------------------------------|
| Bayesian Calculator    | Functional | Core probability calculations working      |
| UUID Generation        | Functional | UUIDv7 generation implemented              |
| Data Validation        | Functional | Ecto changeset validators available        |
| API Stability          | Partial    | Core functions stable, may add features    |

**Warning:** This module provides low-level utilities. Higher-level features may be incomplete or experimental.

## Overview

AriaCore implements essential shared functionality:

- **BayesianCalculator**: Probabilistic reasoning with sliding window support for tracking execution outcomes
- **UUID**: RFC 9562 UUIDv7 generation with timestamp-based ordering
- **Validator**: Common validation functions for Ecto changesets and data integrity

## Core Components

### Bayesian Probability Calculator

Tracks execution success rates using Bayesian inference with sliding windows:

```elixir
# Calculate success probability
probability = AriaCore.BayesianCalculator.calculate_probability(8, 2, 20)
# => 0.8

# Update with new outcome
{new_successes, new_failures} = AriaCore.BayesianCalculator.update_outcome(8, 2, :success, 20)
# => {9, 2}
```

### UUID Generation

Generate RFC 9562 UUIDv7 identifiers:

```elixir
uuid = AriaCore.UUID.generate_v7()
# => "018e7c8d-1234-7abc-9def-123456789abc"
```

### Data Validation

Validate data in Ecto changesets:

```elixir
changeset
|> AriaCore.Validator.validate_uuid_v7(:id)
```

## Architecture

AriaCore follows a utility library pattern:

```
AriaCore
├── BayesianCalculator (Probabilistic calculations)
├── UUID (ID generation)
└── Validator (Data validation)
```

## Dependencies

- **None**: AriaCore is dependency-free and provides pure Elixir utilities

## Development

### Running Tests

```bash
mix test test/aria_core/ --timeout 120
```

### Usage in Other Apps

AriaCore functions are available through the main `AriaCore` module:

```elixir
# In your application code
probability = AriaCore.BayesianCalculator.calculate_probability(successes, failures)
```

## Related Components

- **AriaPlanner**: Uses BayesianCalculator for plan success tracking
- **AriaStorage**: Uses UUID generation for entity IDs
- **AriaAuth**: Uses validation utilities for data integrity

---

**Disclaimer:** Research code providing utility functions. See the root [README.md](../../README.md) for current project status.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `aria_core` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:aria_core, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/aria_core>.
