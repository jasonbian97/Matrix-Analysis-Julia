A=rand(1:10,(3,3))
x=[1,2,3]



y1=x'A*x

y2=0
   for i = 1:3
       for j = 1:3
          global y2 += x'[i]*A[i,j]*x[j]
       end
   end

y2
