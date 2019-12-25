using LinearAlgebra

function lr_schatten(Y, reg::Number)
    (U,s,V) = svd(Y)
    sh = shrink_p_1_2(s, reg)
    Xh = U * diagm(sh) * V'
    return Xh
end

function shrink_p_1_2(y, reg::Real)
    xh = zeros(size(y))
    fun = (y) -> 4/3. * y * cos(1/3. * acos(- (3^(3/2)*reg) / (4*y^(3/2))))^2
    mask = y .> 3/2. * reg^(2/3.)
    xh[mask] = fun.(y[mask])
    return xh
end
