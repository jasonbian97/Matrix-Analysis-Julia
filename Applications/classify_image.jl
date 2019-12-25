using LinearAlgebra
function classify_image(test, train, K::Int)
    # n: lenth of vectorized image
    # p: # of test images
    # m: # of training images per class
    # d = 10: # of classes
    n,p = size(test)
    _,m,d = size(train)
    P = zeros(Float32, n, n, d)

    for i in 1:d
        U,_,_ = svd(train[:,:,i])
        P[:,:,i] = U[:,1:K] * U[:,1:K]'
    end

    err = zeros(Float32, d, p)
    # Further hint: first think about what size err should be
    for i in 1:d
        err[i,:] = sum((test-P[:,:,i]*test).^2, dims=1)
    end

    idx = findmin(err, dims=1)[2] # These are linear indices!!
    idx = [CartesianIndices(size(err))[i][1] for i in vec(idx)] # think about this!
    labels = idx .-1 # Convert to digits in (0−9)

end
