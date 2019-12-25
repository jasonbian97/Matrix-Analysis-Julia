using LinearAlgebra
using Random: seed!
seed!(0); e = randn(length(T))
T = [2.1e-3, 0.136, 0.268, 0.402, 0.536, 0.668, 0.802, 0.936, 1.068, 1.202, 1.336, 1.468, 1.602, 1.736, 1.868, 2.000]
f = 0.5 * exp.(0.8*T) # part a
# f = 0.5 * exp.(0.8*T) + e # part b
d = length(T)-1
A15 = [TT^j for TT in T, j=0:d]
A2 = A15[:,1:3]
x16 = pinv(A15)*f
x2 = pinv(A2)*f
t = range(0,stop=2,length=500)
using Plots; plotly()
plot(t, 0.5*exp.(0.8*t), color =:black, label = "f(t)", ylim=(-1,4))
scatter!(T,f, marker=:circle, color =:black, label = "Samples")
a16 = [tt^j for tt in t, j=0:d]
a2 = a16[:,1:3]
plot!(t,(a16*x16), color =:red, label = "15 poly")
plot!(t,a2*x2, color =:blue, label = "2 poly", xaxis = "t", yaxis = "Value")
#savefig("tmp2.pdf")
