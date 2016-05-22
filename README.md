# Euler_1

** Multiples of 3 and 5

If we list all the natural numbers below 10 that are multiples of 3 or 5, we
get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.

## Approach

There are two solutions defined in the Euler_1 module. The first takes the
range and transforms it in to a stream with just the values we want before
using Enum.sum. The second uses recursion with tail call optimization to add
values to an accumulator if they match what we want.  Ends up recursion was
reliably faster for lists shorter than 1000 items in the benchmarking I did.

    Using 10 tail call optimization is 15% faster
    Using 1000 tail call optimization is 8% faster
    Using 10000 tail call optimization is 3% faster
    Using 100000 tail call optimization is 2% faster
    Using 250000 stream is 5% faster
    Using 500000 stream is 11% faster
    Using 1000000 stream is 14% faster

### Euler_1.using_stream/1

This solution is a pipeline of transforms ending with a sum. To be honest I
wasn't sure if Stream's laziness benefits Enum.sum/1 or not... doesn't seem to
however this method was definitely more performant at larger values. It's worth
noting that the private methods were not refactored out when I started the 2nd
approach - rather I started out writing using stream as it is and figured out
the implementation of the  private methods after the fact. I could have avoided
the private methods and left the transformation in line - but like the more
declarative pipeline in the function serving as the interface. It's more lines
of code but easier to follow.

### Euler_1.using_tail_call_optimization/1

Once I finished using_stream/1 I was curious how the method would look using
recursion. In this case I used a micropattern - having one arity of a method
serve as the interface and another arity of the same method serve as the
implementation.

I originally had a "local assignment" here:
`value_to_add = if desired_value?(head), do: head, else: 0` but considered it
a code smell and moved it to it's own method. Definitely made
using_tail_call_optimization/2 easier to read.

### Euler_1.using_map_reduce/1

Included while trying to figure out if Enum.sum benefitted from Stream and to
show a third solution to the problem. This version uses Stream.filter to map
the values and then reduces the result. Oddly this one seems to perform best at
500,000 items (about 6% faster than using_stream/1) and about the same as the
using_stream/1 version at the other levels.