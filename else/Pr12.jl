using BenchmarkTools

@benchmark z*u'*v*x'*y setup=(u=rand(500), v=rand(500), x=rand(500), y=rand(500), z=rand(500))

@benchmark z*(u'*v)*(x'*y) setup=(u=rand(500), v=rand(500), x=rand(500), y=rand(500), z=rand(500))

@benchmark z*((u'*v)*(x'*y)) setup=(u=rand(500), v=rand(500), x=rand(500), y=rand(500), z=rand(500))
