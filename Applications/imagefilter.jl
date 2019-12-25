using MIRT: jim, ellipse_im # for image display and test image
include("convolution.jl")
X = ellipse_im(128)[15:114,:]
@show (M,N) = size(X)
X = X + 0.5 * randn(size(X)) # add some noise
jim(X, xlabel="x", ylabel="y", "original noisy image") # jiffy image display
# 1D moving-average filter represented as a matrix
hx = ones(9)/9 # 9-pt moving average filter for x (along cols)
hy = ones(5)/5 # 5-pt moving average filter for y (along rows)
Hx,_ = convolution(hx, zeros(M))
Hy,_ = convolution(hy, zeros(N));
# display one of the 1D convolution matrices
# transpose to show it like a matrix H[i,j], rather than as an image f[x,y]
jim(Hx', ylabel="i", xlabel="j")
Y = Hx * X * Hy';
whoami = "Zhangxing Bian (zxbian)" # if this fails, put your name in it manually
jim(Y, xlabel="x", ylabel="y", "filtered image by '$whoami'")
using Plots: savefig
savefig("zxbian-HW1-fig.pdf")
