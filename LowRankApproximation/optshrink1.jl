using Random: seed!
using LinearAlgebra

function optshrink1(Y::AbstractMatrix, r::Int)
    # reference: http://web.eecs.umich.edu/~rajnrao/optshrink/
    (U, s, V) = svd(Y) # economy
    (m,n) = size(Y)
    r = minimum([r, m, n]) # ensure r <= min(m,n)
    if m >= n # tall
        S = [Diagonal(s[(r+1):n]); zeros(m-n,n-r)]
    else # wide
        S = [Diagonal(s[(r+1):m]) zeros(m-r,n-m)]
    end
    w = zeros(r)
    for k=1:r
        (D, Dder) = D_transform_from_matrix(s[k], S)
        w[k] = -2*D/Dder
    end
    Xh = U[:,1:r] * Diagonal(w) * V[:,1:r]' # (m,r) (r,r) (n,r)'
    return Xh
end

function D_transform_from_matrix(z, X)
    # X is n x m, where this internal n,m differ from n,m in calling routine
    # this version makes "big" matrices so it is impractical for big data
    (n,m) = size(X)
    In = I # eye(n)
    Im = I # eye(m)
    denom_n = z^2 * In - X * X' # denominators of the d-transform equation
    denom_m = z^2 * Im - X' * X
    inv_denom_n = inv(Array(denom_n))
    inv_denom_m = inv(Array(denom_m))
    D1 = (1/n) * tr(z * inv_denom_n)
    D2 = (1/m) * tr(z * inv_denom_m)
    D = D1*D2 # eq (16a) in Nadakuditi paper
    # derivative of D transform
    D1_der = (1/n) * tr(-2 *z^2 * inv_denom_n^2 + inv_denom_n)
    D2_der = (1/m) * tr(-2 *z^2 * inv_denom_m^2 + inv_denom_m)
    D_der = D1*D2_der + D2*D1_der # eq (16b) in Nadakuditi paper
    return (D, D_der)
end

# include("optshrink1.jl") # uncomment if you need this

seed!(0)
X = randn(30) * randn(20)'
Y = X + 40 * randn(size(X))
Xh_opt = optshrink1(Y, 1)

(U,s,V) = svd(Y)
Xh_lr = U[:,1] * s[1] * V[:,1]'

@show norm(Xh_opt - X)
@show norm(Xh_lr - X)
