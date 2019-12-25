using LinearAlgebra
"""
Xr = dist2locs(D, d)

In:
* `D` is an `n x n` matrix such that `D[i, j]` is the distance from object `i` to object `j`
* `d` is the desired embedding dimension.

Out:
* `Xr` is an `n x d` matrix whose rows contains the relative coordinates of the `n` objects

Note: MDS is only unique up to rotation and translation,
so we enforce the following conventions on Xr in this order:
* [ORDER] `Xr[:,i]` corresponds to ith largest eigenpair of `C * C'`
* [CENTER] The centroid of the coordinates is zero
* [SIGN] The largest magnitude element of `Xr[:, i]` is positive
"""
function dist2locs(D, d)
    # Parse inputs
    n = size(D, 1)

    # Compute correlation matrix  ensures [CENTER]
    S = D .* D
    S = 0.5 * (S + S') # force symmetry (in case of noise)
    P = I - ones(n, n) / n
    CCt = -0.5 * (P * S * P)
    # Compute relative coordinates
    _, s, V = svd(CCt) # using SVD ensures [ORDER]
    Xr = V[:, 1:d] * Diagonal(sqrt.(s[1:d]))
    # Apply [SIGN]
    Xr .*= sign.(Xr[findmax(abs.(Xr), dims=1)[2]])
    return Xr
end
