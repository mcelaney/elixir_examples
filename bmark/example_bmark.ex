defmodule Example do
  use Bmark
  bmark :using_stream_10, runs: 6 do
    Euler1.using_stream(10)
  end

  bmark :using_stream_1000, runs: 6 do
    Euler1.using_stream(1000)
  end

  bmark :using_stream_10000, runs: 6 do
    Euler1.using_stream(10000)
  end

  bmark :using_stream_100000, runs: 6 do
    Euler1.using_stream(100000)
  end

  bmark :using_stream_250000, runs: 6 do
    Euler1.using_stream(250000)
  end

  bmark :using_stream_500000, runs: 6 do
    Euler1.using_stream(500000)
  end

  bmark :using_stream_1000000, runs: 6 do
    Euler1.using_stream(1000000)
  end

  bmark :using_tail_call_optimization_10, runs: 6 do
    Euler1.using_tail_call_optimization(10)
  end

  bmark :using_tail_call_optimization_1000, runs: 6 do
    Euler1.using_tail_call_optimization(1000)
  end

  bmark :using_tail_call_optimization_10000, runs: 6 do
    Euler1.using_tail_call_optimization(10000)
  end

  bmark :using_tail_call_optimization_100000, runs: 6 do
    Euler1.using_tail_call_optimization(100000)
  end

  bmark :using_tail_call_optimization_250000, runs: 6 do
    Euler1.using_tail_call_optimization(250000)
  end

  bmark :using_tail_call_optimization_500000, runs: 6 do
    Euler1.using_tail_call_optimization(500000)
  end

  bmark :using_tail_call_optimization_1000000, runs: 6 do
    Euler1.using_tail_call_optimization(1000000)
  end

  bmark :using_map_reduce_10, runs: 6 do
    Euler1.using_map_reduce(10)
  end

  bmark :using_map_reduce_1000, runs: 6 do
    Euler1.using_map_reduce(1000)
  end

  bmark :using_map_reduce_10000, runs: 6 do
    Euler1.using_map_reduce(10000)
  end

  bmark :using_map_reduce_100000, runs: 6 do
    Euler1.using_map_reduce(100000)
  end

  bmark :using_map_reduce_250000, runs: 6 do
    Euler1.using_map_reduce(250000)
  end

  bmark :using_map_reduce_500000, runs: 6 do
    Euler1.using_map_reduce(500000)
  end

  bmark :using_map_reduce_1000000, runs: 6 do
    Euler1.using_map_reduce(1000000)
  end

  # Added due to bug in bmark that adds time to the first run of the last
  # example
  bmark :trash, runs: 1 do
    nil
  end

end
