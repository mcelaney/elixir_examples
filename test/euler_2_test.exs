defmodule Euler2Test do
  use ExUnit.Case
  doctest Euler2

  test "perform/1" <>
       "given an integer" <>
       "sums all even Fibonacci numbers below the integer" do
    assert Euler2.perform(50) == 44
  end

  test "perform/1" <>
       "will not error when calculating for large integers" do
    assert Euler2.perform(4000000) == 4613732
  end
end
