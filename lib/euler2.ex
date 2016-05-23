defmodule Euler2 do
  @moduledoc """
  A demonstration of potential solutions to the Project Euler 2 in Elixir
  """

  @doc """
  By considering the terms in the Fibonacci sequence whose values do not exceed
  a max value, find the sum of the even-valued terms.

  We start out by calling perform/1 - which serves as an interface when it's
  passed an integer. It creates a tuple to track data with initial settings
  based on the third Fibonacci number (3)... largely to simplify the methods.
  It then recurses - using a pipeline to trnasform the tuple until it hits the
  max value.

  ## Example

      iex> Euler2.perform(50)
      44
  """
  @spec perform(integer) :: integer
  def perform(top_value) when is_integer(top_value) do
    perform({2, 2, 3, top_value})
  end

  @spec perform({integer, integer, integer, integer}) :: {integer, integer, integer, integer} | integer
  def perform({acc, _, _, nil}), do: acc
  def perform(state) do
    state
    |> add_current_if_even
    |> set_values_for_next_run
    |> validate
    |> perform
  end

  @spec add_current_if_even({integer, integer, integer, integer}) :: {integer, integer, integer, integer}
  defp add_current_if_even({acc, last, current, top_value} = state) do
    if rem(current, 2)  == 0 do
      {acc + current, last, current, top_value}
    else
      state
    end
  end

  @spec set_values_for_next_run({integer, integer, integer, integer}) :: {integer, integer, integer, integer}
  defp set_values_for_next_run({acc, last, current, top_value}) do
    {acc, current, current + last, top_value}
  end

  @spec validate({integer, integer, integer, integer}) :: {integer, integer, integer, integer | nil}
  defp validate({acc, last, current, top_value} = state) do
    if current > top_value do
      {acc, last, current, nil}
    else
      state
    end
  end
end
