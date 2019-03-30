# Curry

Implementation of Currying for Julia.  https://en.wikipedia.org/wiki/Currying

Convert a function that accepts multiple arguments into an equivalent chain of single argument functions.
Functions are chained as single argument anonymous functions that return single argument functions.

If multiple arities of a function exist, the one with the least number of arguments greater than 1 will be curried.  
e.g. arities 1 and greater than 2 exist for -, but arity 2 will be choosen for currying.

Exports the following functions:
* `curry`,
* `partial`,
* `swap`.

Implements the following puns:
* `🍛` (exported)
* `∂`


    julia> curry(map)(sqrt)(1:4)
    4-element Array{Float64,1}:
     1.0
     1.4142135623730951
     1.7320508075688772
     2.0
    
    julia> curry((-))(9)
    #119 (generic function with 1 method)
    
    julia> curry((-))(9)(1)
    8

