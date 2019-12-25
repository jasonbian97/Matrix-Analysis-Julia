using LinearAlgebra

function common_root(p1, p2)
    # Constants
    DELTA = 1e-6
    # Construct companion matrices
    A = compan(p1)
    B = compan(p2)
    C = kron(A, I(size(B,1))) - kron(I(size(A,1)), B)
    # Check for common roots
    return (abs(det(C)) < DELTA)
end

function compan(p)
    n = length(p)
    A = [(-1 / p[1]) * vec(p[2:n])'; [I zeros(n-2)] ]
    return A
end
