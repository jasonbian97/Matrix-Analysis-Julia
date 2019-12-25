"""
`H, y = convolution(h, x)`
Compute discrete convolution of the input vectors via
matrix multiplication, returning both the matrix `H` and result `y`
In:
􀀀 `h` vector of length `K`
􀀀 `x` vector of length `N`
Out:
􀀀 `H` `M x N` convolution matrix defined by `h`
􀀀 `y` vector of length `M` containing the discrete convolution of `h` and `x`,
but *not* computed using `conv` calls.
"""
function convolution(h, x)
    N=length(x)
    K=length(h)
    H = zeros(N + K - 1, N)
    for n=1:N
        H[n:n+K-1,n]=h
    end
    y=H*x
    return H,y
end
