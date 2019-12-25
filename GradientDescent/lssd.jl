using LinearAlgebra
function lssd(A, b ; x0=zeros(size(A,2)), nIters::Int=10)
    # Parse inputs
    b = vec(b) # make sure it is a column
    x0 = vec(x0) # ensure it is a column
    # steepest descent
    x = x0
    Ax = A * x # initialize A * x
    for _ in 1:nIters
    g = A' * (Ax - b) # gradient
    d = - g # search direction: negative gradient
    Ad = A * d
    normAd = norm(Ad)
    if normAd == 0 # done!
    return x
    else
    step = -d' * g / normAd.^2 # from previous HW
    end
    x += step * d
    Ax += step * Ad
    end
    return x
end
