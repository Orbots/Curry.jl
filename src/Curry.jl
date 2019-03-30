module Curry

using InteractiveUtils

export 
curry,
🍛,
partial,
swap

"""
  swap(f)

Return a function with a reordered argument list.  Reordered so first argument becomes the last.
"""
swap(f::Function) = (a, b...)->f(b..., a)

"""
  partial(f, x...)

Takes a function f and fewer than the normal arguments to f, and
returns a function that takes a variable number of additional args. When
called, the returned function calls f with args + additional args.
"""
partial = (f::Function, y...)->(z...)->f(y..., z...)

∂(f::Function, y...) = partial(f, y...)

function curryn(f, n, args)
  if n == 1
    x->f(args...,x)
  else
    x->curryn(f, n-1, vcat(args,x))
  end
end

curryn(f, n) = curryn(f,n,[])

function curry2(f)
  x->y->f(x, y)
end

function curry3(f)
  x->y->z->f(x, y, z)
end

function curry4(f)
  r->x->y->z->f(r, x, y, z)
end

"""
   curry(f)

Convert a function that accepts multiple arguments into an equivalent chain of single argument functions.
Functions are chained as single argument anonymous functions that return single argument functions.

If multiple arities of a function exist, the one with the least number of arguments greater than 1 will be curried.


# Examples
```jldoctest
julia> curry(map)(sqrt)(1:4)
4-element Array{Float64,1}:
 1.0
 1.4142135623730951
 1.7320508075688772
 2.0

# arities 1 and greater than 2 exist for -, but arity 2 will be choosen for currying
julia> curry((-))(9)
#119 (generic function with 1 method)

julia> curry((-))(9)(1)
8
```

"""
@generated function curry(f)
  m = methodswith(f)
  minargs = mapreduce(x->x.nargs, min, m)-1
  maxargs = mapreduce(x->x.nargs, max, m)-1
  if maxargs > 1
    n = max(2, minargs)
    if n == 2
      :(curry2(f))
    elseif n == 3
      :(curry3(f))
    elseif n == 4
      :(curry4(f))
    else
      :(curryn(f, $n))
    end
  else
    :(f)
  end
end

🍛(f) = curry(f)

end
