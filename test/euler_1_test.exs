defmodule Euler1Test do
  use ExUnit.Case
  doctest Euler1

  test "using_stream/1 " <>
       "given an integer " <>
       "sums all numbers divisible by 3 or 5 below the integer" do
    assert Euler1.using_stream(10) == 23
  end

  test "using_tail_call_optimization/1 " <>
       "given an integer " <>
       "sums all numbers divisible by 3 or 5 below the integer" do
    assert Euler1.using_tail_call_optimization(10) == 23
  end

  test "using_map_reduce/1 " <>
       "given an integer " <>
       "sums all numbers divisible by 3 or 5 below the integer" do
    assert Euler1.using_map_reduce(10) == 23
  end

  test "using_calculate_multiples/1 " <>
       "given an integer " <>
       "sums all numbers divisible by 3 or 5 below the integer" do
    assert Euler1.using_calculate_multiples(10) == 23
  end
end
