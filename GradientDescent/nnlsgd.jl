using LinearAlgebra;
function nnlsgd(A, b ; mu::Real=0, x0=zeros(size(A,2)), nIters::Int=200)
    # b = vec(b)
    # x0 = vec(x0)
    if mu == 0
        mu = 1/(opnorm(A,Inf) * opnorm(A,1))
    end
    x = x0
    for i in 1:nIters
        x = max.(0, x - mu * (A' * (A * x - b))) # project onto non􀀀negative orthant
    end
    return x
end

# using Random: seed!
# using Statistics: mean
# using Plots;
# using LinearAlgebra;
#
# seed!(0)
# m = 100; n = 50; sigma = 0.3
# A = randn(m,n)
# xtrue = rand(n) # note that xtrue is non-negative
# b = A * xtrue + sigma * randn(m)
# x0 = A \ b; x0[x0 .<= 0] .= mean(x0[x0 .> 0]) # reasonable initial guess
# sigma1=svdvals(A)[1]
# mu=1/(sigma1^2)
# x_hat = nnlsgd(A,b,mu=mu,nIters=400)
# print(x_hat[1:3]) # [0.20261580855517833, 0.4293932251599541, 0.6499449689682328]

# using Optim # you will likely need to add this package
# using LinearAlgebra: norm
#
# using Plots;
# plotly(); # tell julia which plot backend we want to use
# lower = zeros(n)
# upper = fill(Inf, (n,))
# inner_optimizer = GradientDescent()
# f = x -> 1/2 * norm(A * x - b)^2 # cost function
# function grad!(g, x) # its gradient
#     g[:] = A' * (A * x - b)
# end
# results = optimize(f, grad!, lower, upper, x0,
#     Fminbox(inner_optimizer), Optim.Options(g_tol=1e-12))
# xnnls = results.minimizer
# print(xnnls[5:7]) # [0.6134856782668822, 0.9217903343533413, 0.26569150909206757]
#
# xaxis = LinRange(0,100,101)
# plot()
# for multiple in [0.1 0.5 1 1.9]
#     real_mu = multiple * mu
#     histarr=zeros(1,101)
#     for k in 0:100
#         xk = nnlsgd(A,b,nIters=k,mu=real_mu);
#         histarr[k+1]=log10(norm(xk-xnnls))
#     end
#     plot!(vec(xaxis),vec(histarr),xlabel="k iterations", ylabel="log10(||x_{NNLS}-x_k||)", label=string(multiple) * "/σ₁²")
# end
# #  Why in the for loop this can't show figure.
