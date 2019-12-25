function lsgd(A, b ; mu::Real=0, x0=zeros(size(A,2)), nIters::Int=200, hist::Bool=false)
    if hist==true
        histarr=zeros(size(A,2),nIters)
        # print(histarr)
    end
    b = vec(b)
    x0 = vec(x0)
    x = x0
    for i in 1:nIters
        x -= mu * (A' * (A * x - b))
        histarr[:,i]=x'
    end
    if hist==true
        return histarr
    end
    return x
end

using Plots;
using LinearAlgebra;
plotly(); # tell julia which plot backend we want to use
using Random: seed!
m = 100; n = 50;
seed!(0) # seed random number generator
A = randn(m, n); xtrue = rand(n)

xtrue=reshape(xtrue,n,1)
sigma1=svdvals(A)[1]
mu=1/(sigma1^2)
xaxis = LinRange(1,400,400)

noise=randn(m)
sigma = 0.1
b = A * xtrue + sigma * noise
hist01=lsgd(A,b,mu=mu,nIters=400,hist=true)
norm01=log10.(mapslices(norm,hist01.-A\b,dims=1))
plot(xaxis,vec(norm01),xlabel="k iterations", ylabel="log10(||x-x̂||)", label="σ=0.1")

sigma = 0.5
b = A * xtrue + sigma * noise
hist01=lsgd(A,b,mu=mu,nIters=400,hist=true)
norm01=log10.(mapslices(norm,hist01.-A\b,dims=1))
plot!(xaxis,vec(norm01),label="σ=0.5")
#
sigma = 1
b = A * xtrue + sigma * noise
hist01=lsgd(A,b,mu=mu,nIters=400,hist=true)
norm01=log10.(mapslices(norm,hist01.-A\b,dims=1))
plot!(xaxis,vec(norm01),label="σ=1")
#
sigma = 2
b = A * xtrue + sigma * noise
hist01=lsgd(A,b,mu=mu,nIters=400,hist=true)
norm01=log10.(mapslices(norm,hist01.-A\b,dims=1))
plot!(xaxis,vec(norm01),label="σ=2")
