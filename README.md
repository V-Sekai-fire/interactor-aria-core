# interactor-aria-core

Shared Elixir utilities for the aria applications: a Bayesian success-rate estimator, UUIDv7 generation and changeset validators.

## What it is for

It holds the small helpers the other aria applications share: a success-rate estimate over a sliding window of outcomes, time-ordered identifiers, and validators for Ecto changesets.

## Building and running

It is an application from an umbrella project, and its Mix project points its build, dependencies and configuration at that umbrella's root. Inside the umbrella, `mix test` runs its tests.

## Licence

MIT. See [LICENSE](LICENSE).
