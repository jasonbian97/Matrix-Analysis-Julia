function lsngd(A::AbstractMatrix{<:Number}, b::AbstractVector{<:Number}; x0::AbstractVector{<:Number} = zeros(eltype(b), size(A,2)), nIters::Int = 200, mu::Real = 0)
    b = vec(b)
    x0 = vec(x0)
    # gradient descent
    t = 0
    xLast = x0
    x = x0
    for _ = 1:nIters
        # t update
        tLast = t
        t = 0.5 * (1 + sqrt(1 + 4 * t^2))
        # z update
        z = x + ((tLast - 1) / t) * (x - xLast)
        # x update
        xLast = x
        x = z - mu * (A' * (A * z - b))
    end
    return x
end

function lsgd(A, b ; mu::Real=0, x0=zeros(size(A,2)), nIters::Int=200)
    b = vec(b)
    x0 = vec(x0)
    x = x0
    for i in 1:nIters
        x -= mu * (A' * (A * x - b))
    end
    return x
end

using Plots;
using LinearAlgebra;
plotly(); # tell julia which plot backend we want to use

using Random: seed!
m = 100; n = 50; sigma = 0.1;
seed!(0); A = randn(m, n); xtrue = rand(n);
b = A * xtrue + sigma * randn(m);

histarr=zeros(1,201)
histarr2=zeros(1,201)
sigma1=svdvals(A)[1]

mu=1/(sigma1^2)
for k in 0:200
    xk=lsngd(A,b,nIters=k,mu=mu);
    histarr[k+1]=log10(norm(xk-A\b)/norm(A\b))
    xk=lsgd(A,b,nIters=k,mu=mu);
    histarr2[k+1]=log10(norm(xk-A\b)/norm(A\b))
end
xaxis = LinRange(0,200,201)
plot(xaxis,vec(histarr),xlabel="k iterations", ylabel="log10(||x-x̂||/||x̂||)",title="μ=1/σ₁²", label="lsgnd")
plot!(xaxis,vec(histarr2), label="lsgd")

mu=0.75/(sigma1^2)
for k in 0:200
    xk=lsngd(A,b,nIters=k,mu=mu);
    histarr[k+1]=log10(norm(xk-A\b)/norm(A\b))
    xk=lsgd(A,b,nIters=k,mu=mu);
    histarr2[k+1]=log10(norm(xk-A\b)/norm(A\b))
end
xaxis = LinRange(0,200,201)
plot(xaxis,vec(histarr),xlabel="k iterations", ylabel="log10(||x-x̂||/||x̂||)",title="μ=0.75/σ₁²", label="lsgnd")
plot!(xaxis,vec(histarr2), label="lsgd")

mu=0.5/(sigma1^2)
for k in 0:200
    xk=lsngd(A,b,nIters=k,mu=mu);
    histarr[k+1]=log10(norm(xk-A\b)/norm(A\b))
    xk=lsgd(A,b,nIters=k,mu=mu);
    histarr2[k+1]=log10(norm(xk-A\b)/norm(A\b))
end
xaxis = LinRange(0,200,201)
plot(xaxis,vec(histarr),xlabel="k iterations", ylabel="log10(||x-x̂||/||x̂||)",title="μ=0.5/σ₁²", label="lsgnd")
plot!(xaxis,vec(histarr2), label="lsgd")

mu=0.25/(sigma1^2)
for k in 0:200
    xk=lsngd(A,b,nIters=k,mu=mu);
    histarr[k+1]=log10(norm(xk-A\b)/norm(A\b))
    xk=lsgd(A,b,nIters=k,mu=mu);
    histarr2[k+1]=log10(norm(xk-A\b)/norm(A\b))
end
xaxis = LinRange(0,200,201)
plot(xaxis,vec(histarr),xlabel="k iterations", ylabel="log10(||x-x̂||/||x̂||)",title="μ=0.25/σ₁²", label="lsgnd")
plot!(xaxis,vec(histarr2), label="lsgd")
