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


function fista_schatten(Y, M, reg::Real, niter::Int)
    # Apply ISTA (Iterative Soft-Thresholding Algorithm)
    # Define cost function for optimization problem
    Omega = convert(Array{Bool}, M .== 1)

    # Run FISTA algorithm
    X = copy(Y)
    Z = copy(X)
    Xold = copy(X)
    told = 1
    # beta = ? # use same beta
    # cost_fista = zeros(niter+1)
    # cost_fista[1] = costfun1(X,beta)
    for k=1:niter
        Z[Omega] = Y[Omega]
        X = lr_schatten(Z,reg)
        t = (1 + sqrt(1+4*told^2))/2
        Z = X + ((told-1)/t)*(X-Xold)
        Xold = copy(X)
        told = t
        # cost_fista[k+1] = costfun1(X,beta) # comment out to speed-up
    end
    xh_fista = copy(X)
    return xh_fista
end
