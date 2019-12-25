[Gradient Descent](./GradientDescent/):

- gradient descent for LS problem. [lsgd.jl](./GradientDescent/lsgd.jl)

- Nesterov-accelerated gradient descent  for LS problem. [lsngd.jl](./GradientDescent/lsngd.jl)

- projected gradient descent for LS problem. [nnlsgd.jl](./GradientDescent/nnlsgd.jl)
- Perform steepest descent to solve the least squares problem. [lssd.jl](./GradientDescent/lssd.jl)

Projection:

- Projects `x` onto the orthogonal complement of the null space of the input matrix `A`. [orthcompnull.jl](./projection/orthcompnull.jl)



[Low Rank Approximation](./LowRankApproximation/):

- Optshrink1. This version works only if the size of Y is sufficiently small, because it performs calculations involving arrays roughly of size(Y'*Y) and size(Y*Y') so neither dimension of Y can be large. [optshrink1.jl](./LowRankApproximation/optshrink1.jl)

- Optshrink2. This version works even if one of the dimensions of Y is large, as long as the other is sufficiently small.[optshrink2.jl](./LowRankApproximation/optshrink2.jl)

- Compute minimizer of <img src="https://latex.codecogs.com/svg.latex?\frac{1}{2}&space;|v&space;-&space;x|^2&space;&plus;&space;reg&space;|x|^{1/2}" title="\frac{1}{2} |v - x|^2 + reg |x|^{1/2}" /> when `v` is real and nonnegative. [shrink_p_1_2.jl](./LowRankApproximation/shrink_p_1_2.jl)
- Compute the regularized low-rank matrix approximation as the minimizer over `X` of <img src="https://latex.codecogs.com/svg.latex?\frac{1}{2}&space;\|Y&space;-&space;X\|^2&space;&plus;&space;reg&space;R(x)" title="\frac{1}{2} \|Y - X\|^2 + reg R(x)" />, where <img src="https://latex.codecogs.com/svg.latex?R(X)&space;=\sum_k&space;{\sigma_k(X)}^{1/2}" title="R(X) =\sum_k {\sigma_k(X)}^{1/2}" />. [lr_schatten.jl](./LowRankApproximation/lr_schatten.jl)



[Companion Matrix](./CompanionMatrix/)

- Determine whether the input polynomials share a common root. [common_root.jl](./CompanionMatrix/common_root.jl)
- Use power iteration to compute the largest and smallest magnitude zeros, respectively, of the polynomial defined by the input coefficients. [outlying_zeros.jl](./CompanionMatrix/outlying_zeros.jl)



[Matrix Completion](./MatrixCompletion/):

- Perform `niter` FISTA iterations to perform matrix completion by seeking the minimizer over `X` of <img src="https://latex.codecogs.com/svg.latex?1/2&space;\|M&space;.*&space;(Y&space;-&space;X)\|^2&space;&plus;&space;reg&space;R(x)" title="1/2 \|M .* (Y - X)\|^2 + reg R(x)" />, where `R(X)` is the Schatten p-norm of `X` raised to the `p`th power, for `p=1/2`, i.e., <img src="https://latex.codecogs.com/svg.latex?R(X)&space;=&space;\sum_k&space;(\sigma_k(X))^{1/2}" title="R(X) = \sum_k (\sigma_k(X))^{1/2}" />.[fista_schatten.jl](./MatrixCompletion/fista_schatten.jl)



[Applications](./Applications/):

Procrustes. [procrustes.jl](./Applications/procrustes.jl)

Convolution. [convolution.jl](./Applications/convolution.jl)

compress_image. [compress_image.jl](./Applications/compress_image.jl)

Multi-Demension-Scaling. [dist2locs.jl](./Applications/dist2locs.jl)

Power Iteration. [outlying_zeros.jl](./CompanionMatrix/outlying_zeros.jl)

Classify Images: Classify `test` signals using `K`- dimensional subspaces found from `train`ing data via SVD. [classify_image.jl](./Applications/classify_image.jl)







