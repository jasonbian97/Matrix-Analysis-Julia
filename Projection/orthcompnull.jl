
using LinearAlgebra
function orthcompnull(A, x)
    x = vec(x)
    (_, s, V) = svd(A)
    r = sum(s.>0)
    Vr = V[:,1:r]
    return Vr * (Vr' * x)
end
