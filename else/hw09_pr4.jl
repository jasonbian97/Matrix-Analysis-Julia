using LinearAlgebra

N = 4
C = [-1 1 0 0;0 -1 1 0; 0 0 -1 1; 1 0 0 -1]
@show eigvals(C)

@show λ1= -1 + exp(-2*pi*im*(N-1)*1/N)
@show λ2= -1 + exp(-2*pi*im*(N-1)*2/N)
@show λ3= -1 + exp(-2*pi*im*(N-1)*3/N)
@show λ4= -1 + exp(-2*pi*im*(N-1)*4/N)
