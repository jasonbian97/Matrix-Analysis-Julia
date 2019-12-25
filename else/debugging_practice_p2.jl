"""
This is the docstring for the function addnoise. If you type ?addnoise at the
    julia prompt, you should see this full message.

    This function has not been vetted - there are bugs you need to find in it!

The goal of this function is to add white Guassian noise with a given standard
    deviation to every element in x

Input:
    x : input matrix that we want to add noise to
    σ : standard deviation of the noise (default=1)
"""
function addnoise(x; σ=1) # julia makes it really easy to provide default values
    noise = σ*randn()
    return noise .+ x
end

"""
sinc function is defined as 1 if x=0 and sin(πx)/(πx) else.

Input:
    x : input number
Output
    Float64 of value 1 if x=0 and sin(x)/x else
"""
my_sinc = (x) -> (x==0) ? 1 : sin(π*x)/(π*x)

"""
This could also be achieved in one-line as:
    binaryround(x) = x > 0.5 ? 1 : 0 # returns 0 if x <= 0.5, returns 1 if x > .5
"""
function binaryround(x)::Float64
    if x > 0.5
        # x = x + [1] # uncomment this (bad) line as a test of debugging
        # you should be able to step to it and see what x is currently defined as
        return 1
    elseif x <= 0.5
        return 0
    end
end
