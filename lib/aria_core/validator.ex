# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule AriaCore.Validator do
  @moduledoc """
  Utility module for common validations.

  This module provides reusable validation functions for Ecto changesets,
  particularly focused on UUID validation and other common data integrity checks.

  ## Validators

  - **UUIDv7 Validation**: Validates RFC 9562 UUIDv7 format
  - **Extensible**: Easy to add new validation functions

  ## Usage

  ```elixir
  # In an Ecto changeset
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:id, :name])
    |> AriaCore.Validator.validate_uuid_v7(:id)
  end
  ```
  """

  @doc """
  Validates if a string is a valid RFC 9562 UUIDv7.
  """
  @spec validate_uuid_v7(Ecto.Changeset.t(), atom()) :: Ecto.Changeset.t()
  def validate_uuid_v7(changeset, field) do
    Ecto.Changeset.validate_change(changeset, field, fn _, value ->
      if String.match?(value, ~r/^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/) do
        []
      else
        [{field, "must be a valid RFC 9562 UUIDv7"}]
      end
    end)
  end
end
