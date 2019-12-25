function ngd(grad, x0; niter::Int = 200, L::Real = 0, fun = (x, iter) -> 0)

    # these lines initialize the output array to have the correct size/type
    fun_x0 = fun(x0, 0)
    out = similar(Array{typeof(fun_x0)}, niter+1)
    out[1] = fun_x0

    # set up some variables
    x = copy(x0)
    xold = copy(x0)
    told = 1

    # run the FGD for niter iterations
    for iter=1:niter
        t = 0.5 * (1 + sqrt(1 + 4 * told^2)) # TODO: update t
        z = x + ((told - 1) / t) * (x - xold)# TODO: update z
        x = z - 1/L * grad(z)# TODO: update x
        told = copy(t)
        xold = copy(x)
        out[iter+1] = fun(x, iter) # compute cost each iteration
    end

    return x, out
end
