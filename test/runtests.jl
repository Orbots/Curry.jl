using Curry
using Test

@test curry(map)(x->x^2)(1:10) == map(x->x^2,1:10)
@test 🍛(map)(x->x^2)(1:10) == map(x->x^2,1:10)

@test partial(map,partial(swap((^)),2))(1:10) == map(x->x^2, 1:10)

@test curry((-))(9)(1) == 8

foo5(a,b,c,d,r) = ((a+b*c)/d)^r

@test curry(foo5)(1)(2)(3)(4)(5) ≈ foo5(1,2,3,4,5)
