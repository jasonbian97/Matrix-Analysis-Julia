using LinearAlgebra
using Random: seed!

function optshrink2(Y::AbstractMatrix, r::Int)
    # reference: http://web.eecs.umich.edu/~rajnrao/optshrink/
    (U, s, V) = svd(Y)
    (m,n) = size(Y)
    r = minimum([r, m, n])
    # tail singular values for noise estimation
    sv = s[(r+1):end]
    w = zeros(r)
    for k=1:r
        (D, Dder) = D_z_S(s[k], sv, max(m,n)-r, min(m,n)-r)
        w[k] = -2*D/Dder
    end
    Xh = U[:,1:r] * Diagonal(w) * V[:,1:r]'
    return Xh
end

function D_z_S(z, sn, m, n)
    # sn is of length n <= m
    sm = [sn; zeros(m-n)] # m x 1
    inv_n = 1 ./ (z^2 .- sn.^2) # vector corresponding to diagonal
    inv_m = 1 ./ (z^2 .- sm.^2)
    D1 = (1/n) * sum(z * inv_n)
    D2 = (1/m) * sum(z * inv_m)
    D = D1*D2 # eq (16a) in Nadakuditi paper
    # derivative of D transform
    D1_der = (1/n) * sum(-2 * z^2 .* inv_n.^2 + inv_n)
    D2_der = (1/m) * sum(-2 * z^2 .* inv_m.^2 + inv_m)
    D_der = D1*D2_der + D2*D1_der # eq (16b) in Nadakuditi paper
    return (D, D_der)
end


# seed!(0)
# X = randn(10^5) * randn(100)' / 8 # test large case now
# Y = X + randn(size(X))
# Xh_opt = optshrink2(Y, 1)
# (U,s,V) = svd(Y)
# Xh_lr = U[:,1] * s[1] * V[:,1]'
# @show norm(Xh_opt - X)
# @show norm(Xh_lr - X)
