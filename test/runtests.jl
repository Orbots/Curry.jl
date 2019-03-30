using Curry
using Test

@testset "Curry.jl" begin
  @test curry(map)(x->x^2)(1:10) == map(x->x^2,1:10)
  @test 🍛(map)(x->x^2)(1:10) == map(x->x^2,1:10)

  @test partial(map,partial(swap((^)),2))(1:10) == map(x->x^2, 1:10)

  @test curry((-))(9)(1) == 8
end
