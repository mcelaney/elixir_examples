defmodule Euler1 do
  @moduledoc """
  A demonstration of potential solutions to the Project Euler 1 in Elixir
  """

  @doc """
  Returns the sum of all values below a given number which are multiples
  of 3 or 5.

  This solution is a pipeline of transforms ending with a sum. To be honest I
  wasn't sure if Stream's laziness benefits Enum.sum/1 or not... doesn't seem to
  however this method was definitely more performant at larger values. It's worth
  noting that the private methods were not refactored out when I started the 2nd
  approach - rather I started out writing using stream as it is and figured out
  the implementation of the  private methods after the fact. I could have avoided
  the private methods and left the transformation in line - but like the more
  declarative pipeline in the function serving as the interface. It's more lines
  of code but easier to follow.

  If we ignore using_calculate_multiples/1 this method is fastest above 100,000
  items - except that at 500,000 items using_map_reduce/1 ended up winning.

  ## Example

      iex> Euler1.using_stream(10)
      23
  """
  @spec using_stream(integer) :: integer
  def using_stream(value) do
    value
    |> find_range
    |> create_stream_of_desired_values
    |> Enum.sum
  end

  @doc """
  Returns the sum of all values below a given number which are multiples
  of 3 or 5.

  Once I finished using_stream/1 I was curious how the method would look using
  recursion. In this case I used a micropattern - having one arity of a method
  serve as the interface and another arity of the same method serve as the
  implementation.

  I originally had a "local assignment" here:
  `value_to_add = if desired_value?(head), do: head, else: 0` but considered it
  a code smell and moved it to it's own method. Definitely made
  using_tail_call_optimization/2 easier to read.

  If we ignore using_calculate_multiples/1 this method is fastest up to about
  100,000 items.

  ## Example

      iex> Euler1.using_tail_call_optimization(10)
      23
  """
  @spec using_tail_call_optimization(integer) :: integer
  def using_tail_call_optimization(value) do
    value
    |> find_range
    |> Enum.to_list
    |> using_tail_call_optimization(0)
  end
  @spec using_tail_call_optimization([], integer) :: integer
  defp using_tail_call_optimization([], acc), do: acc
  defp using_tail_call_optimization([head|tail], acc) do
    using_tail_call_optimization(tail, (acc + value_to_add(head)))
  end

  @doc """
  Returns the sum of all values below a given number which are multiples
  of 3 or 5.

  Included while trying to figure out if Enum.sum benefitted from Stream and to
  show a third solution to the problem. This version uses Stream.filter to map
  the values and then reduces the result. Oddly - if we ignore
  using_calculate_multiples/1 - this one seems to perform best at 500,000 items
  (about 6% faster than using_stream/1) and about the same as the using_stream/1
  version at the other levels.

  ## Example

      iex> Euler1.using_map_reduce(10)
      23
  """
  @spec using_map_reduce(integer) :: integer
  def using_map_reduce(value) do
    value
    |> find_range
    |> create_stream_of_desired_values
    |> Enum.reduce(0, &(&1 + &2))
  end

  @doc """
  Returns the sum of all values below a given number which are multiples
  of 3 or 5.

  While working on Euler2 I realized the calculating the multiples might
  actually be faster than iterating over every number - which lead to this
  solution. We calculate the results for multiples of 3 and 5 separately -
  adding each result to the accumulator.

  It turned out to be around 85% faster than the next fastest answer
  for all examples.

  ## Example

      iex> Euler1.using_calculate_multiples(10)
      23
  """
  @spec using_calculate_multiples(integer) :: integer
  def using_calculate_multiples(value) do
    using_calculate_multiples([3,5], value, 0)
  end
  def using_calculate_multiples([], _, acc), do: acc
  def using_calculate_multiples([head|tail], value, acc) do
    using_calculate_multiples(
      tail,
      value,
      sum_multiples_up_to({head, {head, value}, acc})
    )
  end

  @spec create_stream_of_desired_values(%{}) :: %{}
  defp create_stream_of_desired_values(range) do
    Stream.filter(range, fn(x) -> desired_value?(x) end)
  end

  @spec desired_value?(integer) :: boolean
  defp desired_value?(number) do
    cond do
      rem(number, 3) == 0 -> true
      rem(number, 5) == 0 -> true
      true                -> false
    end
  end

  @spec find_range(integer) :: Range.t
  defp find_range(value) do
    Range.new(0, value - 1)
  end

  defp sum_multiples_up_to({nil, _, acc}), do: acc
  defp sum_multiples_up_to({next, {_, stop_at}, _} = current_state) do
    current_state
    |> update_sum_multiples_up_to_state(next < stop_at)
    |> sum_multiples_up_to
  end

  defp update_sum_multiples_up_to_state({curr, {i, stop_at}, acc}, true) do
    {curr + i, {i, stop_at}, acc + curr}
  end
  defp update_sum_multiples_up_to_state({_, _, acc}, false) do
    {nil, nil, acc}
  end

  @spec value_to_add(integer) :: integer
  defp value_to_add(value) do
    if desired_value?(value), do: value, else: 0
  end
end
