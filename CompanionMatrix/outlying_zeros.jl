using LinearAlgebra

function outlying_zeros(p ; v0::Vector{<:Real}=randn(length(p)-1), nIters::Int=100)
    # Compute largest absolute zero
    Cmax = compan(p)
    zmax = powerIteration(Cmax, v0, nIters)[1]
    # Compute smallest absolute zero
    Cmin = compan(p[end:-1:1])
    zmin = 1 / powerIteration(Cmin, v0, nIters)[1]
    return zmax, zmin
end

function powerIteration(A, v0, nIters)
    # Power iteration
    lambda1 = 0
    v1 = v0 / norm(v0)
    # v1 = v0
    for _ in 1:nIters
        Av1 = A * v1
        lambda1 = v1' * Av1
        # lambda1 = norm(Av1) / norm(v1)
        v1 = Av1 / norm(Av1)
    end
    return lambda1, v1
end

function compan(p)
    n = length(p)
    A = [(-1 / p[1]) * vec(p[2:n])'; [I zeros(n-2)] ]
    return A
end
