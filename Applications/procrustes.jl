using LinearAlgebra
using Statistics: mean
function procrustes(B, A ; center=true, scale=true)
    muB = mean(B, dims=2)
    muA = mean(A, dims=2)
    B0 = B .- muB
    A0 = A .- muA

    U, _, V = svd(B0 * A0')
    Q = U * V'

    alpha = tr(B0 * A0' * Q') / tr(A0*A0')

    Aa = alpha * (Q * A0) .+ muB
    return Aa
end

using Plots
# load data if needed (you must have web access to run this)
if !@isdefined(url)
    url = "http://web.eecs.umich.edu/~fessler/course/551/data/digits/"
    url1a = url * "digit1a2x10int16.dat"
    url1b = url * "digit1b2x10int16.dat"
    url2a = url * "digit2a2x10int16.dat"
    url2b = url * "digit2b2x10int16.dat"
    npoint = 10
    # plot first figure
    A = Array{Int16}(undef, (2,npoint))
    B = Array{Int16}(undef, (2,npoint))
    read!(download(url1a), A)
    read!(download(url1b), B)
end
plotly()
# plot points with first point marked for clarity
plot(A[1,:], A[2,:], color=:red, marker=:circle, label="A: misaligned")
scatter!([A[1,1]], [A[2,1]], color=:red, marker=:square, label="")
plot!(B[1,:], B[2,:], color=:blue, marker=:circle, label="B: target")
scatter!([B[1,1]], [B[2,1]], color=:blue, marker=:square, label="")
plot!(legend=:bottomleft, aspect_ratio=:equal)
# Procrast
Aa1 = procrustes(B,A)
plot(Aa1[1,:], Aa1[2,:], color=:red, marker=:circle, label="Aa: aligned")
scatter!([Aa1[1,1]], [Aa1[2,1]], color=:red, marker=:square, label="")
plot!(B[1,:], B[2,:], color=:blue, marker=:circle, label="B: target")
scatter!([B[1,1]], [B[2,1]], color=:blue, marker=:square, label="")
plot!(legend=:bottomleft, aspect_ratio=:equal)

# plot second figure
read!(download(url2a), A)
read!(download(url2b), B)
plot(A[1,:], A[2,:], color=:red, marker=:circle, label="A: misaligned")
scatter!([A[1,1]], [A[2,1]], color=:red, marker=:square, label="")
plot!(B[1,:], B[2,:], color=:blue, marker=:circle, label="B: target")
scatter!([B[1,1]], [B[2,1]], color=:blue, marker=:square, label="")
plot!(legend=:bottomleft, aspect_ratio=:equal)
# Procrust
Aa2 = procrustes(B,A)
plot(Aa2[1,:], Aa2[2,:], color=:red, marker=:circle, label="Aa: aligned")
scatter!([Aa2[1,1]], [Aa2[2,1]], color=:red, marker=:square, label="")
plot!(B[1,:], B[2,:], color=:blue, marker=:circle, label="B: target")
scatter!([B[1,1]], [B[2,1]], color=:blue, marker=:square, label="")
plot!(legend=:bottomleft, aspect_ratio=:equal)
