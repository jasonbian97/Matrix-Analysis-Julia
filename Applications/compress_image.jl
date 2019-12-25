using LinearAlgebra
using Images
using FileIO
#Colors,
using Interact
using Plots
plotly()
gr()
# Goal: `Ac` a `m x n` matrix containing a compressed version of `A` that can be
# represented using at most `(100 * p)%` as many bits
required to represent `A`
function compress_image(A, p)
    m, n = size(A)
    # Compute compression factor
    r = Int64(floor(p * m * n / (m + n + 1)))
    r = minimum([r, m, n])
    # Compute compressed image
    U, s, V = svd(A)
    Ac = U[:, 1:r] * Diagonal(s[1:r]) * V[:, 1:r]'
    return Ac, r
end
image_color = load("panda.jpg")
image_gray = convert(Array{Gray{Float32}}, image_color)
