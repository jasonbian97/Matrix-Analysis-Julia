using LinearAlgebra
using Polynomials
function poly_coeff(a, b, c, d)
    A1 = [2*a -a^2+b; 1 0]
    A2 = [2*c -c^2+d; 1 0]
    A3 = kron(A1,I(2)) + kron(I(2),A2)
    A4 = kron(A1,A2)
    p = round.(poly(A3)[4:-1:0])
    q = round.(poly(A4)[4:-1:0])
    return (p,q)
end
