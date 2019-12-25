using LinearAlgebra

function outlying_zeros(p;v0::Vector{<:Real} = randn(length(p)-1),nIters::Int = 100)

    n=size(p,1)-1
    v1 = v0
    
    B = zeros(n,n)
    p2 = reverse(p;dims = 1)
    B[1,:] = B[1,:]-p2[2:end]./p2[1]
    [B[i+1,i] = 1 for i = 1:n-1]


    A = zeros(n,n)
    A[1,:] = A[1,:]-p[2:end]./p[1]
    [A[i+1,i] = 1 for i = 1:n-1]

    for i = 1:nIters
        v0 = A*v0 ./norm(A*v0,2)
        v1 = B*v1 ./norm(B*v1,2)
    end
    zmax = v0'*(A*v0)
    if (A[1,n]==0)
        zmin = 0
    else
        zmin = 1/(v1'*(B*v1))
    end
    return zmax,zmin
end
