function orthcomp1(y, x)
    x = vec(x)
    y = vec(y)
    return y - ((x'y) / (x'x)) * x
end
