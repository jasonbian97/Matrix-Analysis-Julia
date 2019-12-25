# This code has lots of bugs in it - your challenge is to find them!

# In future code, you won't have to re-download packages, but you always have
#   to include these "using" statements - they tell the compiler (and users)
#   which packages they need to have on their system.
using Random: seed!
using Plots
using MIRT
using LinearAlgebra

include("debugging_practice_p2.jl")

# Part 1: Make a new matrix
m = [0 1; -1 0] # we can enter a matrix manually
display(m) # print m to the console
m = randn(5,5) # we can initialize one randomly
m = [i+j for i=1:5, j=1:6] # or we could create one from comprehensions
display(m)
m = m/2 # what type will m be (try guessing it first)?
# TODO: write code using the typeof command to determine m's current type


# Part 2: Array reductions: many functions in Julia have an array method
#   to be applied to specific dimensions of an array
# If you have problems calling a function, you can type ?[function name] at the
#   julia terminal to read the docstring
sum(m,dims=1)            # take the sum over the first dimension
maxval, maxind = findmax(m)    # find the max element and its index
@assert maxval == m[maxind]    # this should return true

# Part 3: Broadcasting: when you combine arrays of different sizes in an operation,
#   an attempt is made to "spread" or "broadcast" the smaller array
#   so that the sizes match up. broadcast operators are preceded by a dot:
m .+ 3                  # add 3 to all elements
f = (x) -> cos.(x .^2)     # define a function that operates on a single number
x = sqrt.([0 pi/4 π/2]) # construct a test vector of known values
# you need the dot to tell julia to apply the sqrt function element-wise to the
#   vector "broadcast the sqrt function to the vector"
f(x) # you should be able to guess the output of this

# Part 4: slices and views
m = randn(5,4,3,2)
m1 = m[:,2,:,:] # holds dim 2 fixed
m1[:,:,1] = zeros(5,3) # update some values to be zero


# Part 5: use the BenchmarkTools package function btime to test timing some code
x = rand(1_000_000)
# TODO: which of the following functions do you think will be faster?
# TODO: verify the output of the following functions is the same
#   e.g., sqrt(sum(x.^2)) needs to equal norm(x)
@btime sqrt(sum(x.^2))
@btime norm(x)


# warning: the next sections get more challenging - there are a lot of bugs!

# Part 6: Let's practice plotting and labelling axis
x = LinRange(0,2π,100) # create a vector from 0 to 2π with 100 elements
f = (x) -> cos(x^2) # define a function
y = f.(x)
plotly(); # tell julia which plot backend we want to use
plot(x,y,label="cos(x^2)")
plot!(x,my_sinc.(x),label="sinc(x)")
# the ! after plot tells julia to use the same plot (like "hold on" in matlab)

# Part 7: let's practice using the debugging to step into function
# Define the following funciton by selecting it and hitting "ctrl-enter"
#   or selecting, right click, and pick "run block"
# Once defined, in the terminal, enter "Juno.@enter practice_debugging()"
# Check the "break on exception" box and then the "Debug: continue". You should
#   break at an error.
# Also try to figure out by experimenting the difference between the "next line"
#   and "next expression" debug buttons
function practice_debugging()
    println("just starting the function")
    x = [0 .4 .5 1] # try finding x in your workspace
    # is it still there when you hit the bug?
    println("time to call binaryround")
    binaryround(.6)
end

# Part 8: Once you've fixed the binaryround function, do another plotting example
xtrue = rand(0:1,100) # make a random binary signal
x = addnoise(x,σ=0.5)
xhat = binaryround.(x)
BER(x)::Float16 = sum(abs.(x-xtrue))/length(xtrue) # Bit error rate calculation
plotly();
plot(xtrue, label="true signal");
plot!(x, label="noisy signal"*" (BER="*string(BER(x))*")");
plot!(xhat, label="reconstructed signal"*" (BER="*string(BER(xhat))*")")
title!("Simple denoising of a binary vector")

# Part 9: TODO: make a plot with three lines:
# (1) the sinc function
# (2) the sinc function with noise added (σ=0.01)
# (3) the sinc function with noise added (σ=0.2)
# Your plot should go from [-π, π], include a legend, x axis label, and a title
# Do not call randn in your code! You should use the addnoise function that is
#   in the debugging_practice_p2.jl file
