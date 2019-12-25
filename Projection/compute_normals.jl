using LinearAlgebra

function compute_normals(data, L)
    # data: m,n,d
    # `L` `3 x d`
    # `N` `m x n x 3`
    m, n, d = size(data)
    L = mapslices(normalize, L, dims=1)
    # Flatten each image into one row.
    data = reshape(data, m * n, d)
    N = data * pinv(L)
    N = reshape(N, m, n, 3)
    # normalize along axis=3
    N = mapslices(normalize, N, dims=3)
    return N
end
