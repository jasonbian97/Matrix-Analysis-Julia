using SparseArrays
using LinearAlgebra

function Dn(n)
    Dn = spdiagm(0 => -ones(n), 1 => ones(n-1), 1-n => [1])
    return Dn
end

function first_diffs_2d_matrix(m, n)
    D = [kron(sparse(I, n, n), Dn(m)); kron(Dn(n), sparse(I, m, m))]
    return D
end
