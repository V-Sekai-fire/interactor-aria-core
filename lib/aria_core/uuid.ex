# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule AriaCore.UUID do
  @moduledoc """
  Utility module for generating RFC 9562 UUIDs.

  This module provides UUID generation utilities, specifically focusing on
  UUIDv7 which includes timestamp information for better database indexing
  and sorting capabilities.

  ## UUIDv7 Features

  - **Timestamp-based**: Includes Unix timestamp for chronological ordering
  - **Monotonically increasing**: Within the same millisecond, IDs are sortable
  - **High entropy**: Random component ensures uniqueness
  - **Database-friendly**: Better than random UUIDs for indexed columns

  ## Usage

  ```elixir
  # Generate a new UUIDv7
  uuid = AriaCore.UUID.generate_v7()
  # => "018e7c8d-1234-7abc-9def-123456789abc"
  ```
  """

  @doc """
  Generates a UUIDv7.
  """
  @spec generate_v7() :: String.t()
  def generate_v7() do
    UUIDv7.generate()
  end
end
