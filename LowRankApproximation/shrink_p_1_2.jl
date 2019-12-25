using LinearAlgebra

function shrink_p_1_2(y, reg::Real)
    xh = zeros(size(y))
    fun = (y) -> 4/3. * y * cos(1/3. * acos(- (3^(3/2)*reg) / (4*y^(3/2))))^2
    mask = y .> 3/2. * reg^(2/3.)
    xh[mask] = fun.(y[mask])
    return xh
end

# using Plots
# plotly()
# reg = 2
# x= LinRange(0, 8*reg, 801)
# v = LinRange(0, 8*reg, 801)
# plot(x,v,label="v")
#
# shrinkage = shrink_p_1_2(v,2)
# plot!(x,shrinkage, label="Shrinkage_x")
#
# soft = max.(0,v.-reg)
# plot!(x,soft, label="Soft_x")
