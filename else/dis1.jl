using Plots
using MIRT: jim
using LinearAlgebra: norm
# Read the MNIST data file for 0 and 1 digits
# Download from web if needed
file0 = "data0"
file1 = "data1"
if !isfile(file0)
    download("http://cis.jhu.edu/~sachin/digit/data0", file0)
end
if !isfile(file1)
    download("http://cis.jhu.edu/~sachin/digit/data1", file1)
end

nx = 28 # Original image size
ny = 28
nrep = 1000

x0 = Array{UInt8}(undef, (nx,ny,nrep))
read!(file0, x0)

x1 = Array{UInt8}(undef, (nx,ny,nrep))
read!(file1, x1)

iy = 2:ny
x0 = x0[:,iy,:] # Make images non-square to help debug
x1 = x1[:,iy,:]
ny = length(iy)

# Convert images to Float64 to avoid overflow errors
x0 = Array{Float64}(x0)
x1 = Array{Float64}(x1)

display(size(x0))
# Function to display mosaic of multiple images
imshow3 = (x) -> begin
    tmp = permutedims(x, [1, 3, 2])
    println(size(tmp))
    tmp = reshape(tmp, :, ny)
    heatmap(1:size(tmp,1), 1:ny, transpose(tmp),
        xtick=[1,nx], ytick=[1,ny], yflip=true,
        color=:grays, aspect_ratio=1)
end
# Look at a couple of the images
imshow3(cat(x0[:,:,50:51], x1[:,:,601:602], dims = 3))
# Use some data for training, and some for testing
ntrain = 100
ntest = nrep - ntrain
train0 = x0[:,:,1:ntrain] # Training data
train1 = x1[:,:,1:ntrain]
test0 = x0[:,:,(ntrain+1):end] # Testing data
test1 = x1[:,:,(ntrain+1):end];
# Look at mean image from each class just to get a sense of things
using Statistics: mean

mean0 = mean(train0, dims = 3)
mean1 = mean(train1, dims = 3)

imshow3(cat(mean0, mean1, dims = 3))
# Write a function to classify all the test data
# You need to figure out what the inputs this function should be!
# Have the one output be the classification (0 or 1) for a single test sample
function classify(testimg,mean0, mean1)
    testimg=testimg[:]
    mean0=mean0[:]
    mean1=mean1[:]
    dis0=(mean0'testimg)/norm(mean0)*norm(testimg)
    dis1=(mean1'testimg)/norm(mean1)*norm(testimg)
    return dis0<dis1 ? 1 : 0
end
# Calculate the percentage of correctly classified digits

# you need to fill in the arguments to classify based on your definition
correct0 = [classify(test0[:,:,n],mean0, mean1) == 0 for n = 1:ntest]
correct1 = [classify(test1[:,:,n],mean0, mean1) == 1 for n = 1:ntest]

# Display your results
display("Percent 0 correct = $(sum(correct0) / ntest)")
display("Percent 1 correct = $(sum(correct1) / ntest)")
# Find the indexes of the misclassified digits
incorrect0 = findall(x -> !x, correct0)
incorrect1 = findall(x -> !x, correct1)
@show(incorrect0, incorrect1);


# Display the incorrectly classified digits
# write your code here - you can use either jim or imshow3
# you need to define a new classify function
# You need to figure out what the inputs this function should be!
# have it output the classification (0 or 1) for a single test sample
function classify_nn(sample,train0,train1)
    train0=permutedims(train0, [3, 1, 2])
    train1=permutedims(train1, [3, 1, 2])
    train0=reshape(train0,100,:)
    train1=reshape(train1,100,:)
    train=vcat(train0,train1)
    println(size(train))
    sample=reshape(sample,1,:)
    distM=(train.-sample).*(train.-sample)
    distV=sum(distM,dims=2)
    return argmin(vec(distV))<=100 ? 0 : 1
    # println(argmin(distV,dims=1))
    # println("distV",size(distV))
    # println("distM",size(distM))
    # println(size(sample))
    # println(size(train0))
    # println(size(train1))
end
# Calculate the percentage of correctly classified digits

# you need to fill in the arguments to classify() based on your definition
correct0_nn = [classify_nn(test0[:,:,n],train0,train1) == 0 for n = 1:ntest]
correct1_nn = [classify_nn(test1[:,:,n],train0,train1) == 1 for n = 1:ntest]

# Uncomment these lines to display your results
display("Percent 0 correct = $(sum(correct0_nn) / ntest)")
display("Percent 1 correct = $(sum(correct1_nn) / ntest)")
