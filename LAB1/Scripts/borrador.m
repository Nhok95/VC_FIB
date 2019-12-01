i = 1;
x = [1 2 3 4 5]

x =

     1     2     3     4     5

x = x'

x =

     1
     2
     3
     4
     5

x(1)

ans =

     1

y = (1,1,1,1,1);
 y = (1,1,1,1,1);
       ?
Error: Expression or statement is incorrect--possibly unbalanced (, {, or [.
 
y = [1,1,1,1,1];
x*y

ans =

     1     1     1     1     1
     2     2     2     2     2
     3     3     3     3     3
     4     4     4     4     4
     5     5     5     5     5

y*x

ans =

    15

x.*y

ans =

     1     1     1     1     1
     2     2     2     2     2
     3     3     3     3     3
     4     4     4     4     4
     5     5     5     5     5

y.*x

ans =

     1     1     1     1     1
     2     2     2     2     2
     3     3     3     3     3
     4     4     4     4     4
     5     5     5     5     5

x.*y

ans =

     1     1     1     1     1
     2     2     2     2     2
     3     3     3     3     3
     4     4     4     4     4
     5     5     5     5     5

x = x'

x =

     1     2     3     4     5

x.*y

ans =

     1     2     3     4     5

y.*x

ans =

     1     2     3     4     5

x.*y

ans =

     1     2     3     4     5

y.*x

ans =

     1     2     3     4     5

x*y
Error using  * 
Inner matrix dimensions must agree.
 
x^2
Error using  ^ 
Inputs must be a scalar and a square matrix.
To compute elementwise POWER, use POWER (.^) instead.
 
x.^2

ans =

     1     4     9    16    25

z = [1:4; 5:8; 9:12]

z =

     1     2     3     4
     5     6     7     8
     9    10    11    12

z(1,2)

ans =

     2

z(2,2)

ans =

     6

z(2,4)

ans =

     8

n = z(1:2,:)

n =

     1     2     3     4
     5     6     7     8

n

n =

     1     2     3     4
     5     6     7     8

delete(n)
Error using delete
Invalid or deleted object.
 
size (n)

ans =

     2     4

clearvars n
z (:,3:end)

ans =

     3     4
     7     8
    11    12

z (:,end-1:end)

ans =

     3     4
     7     8
    11    12

z = [x y];
z(:,2) = [];
z = [1:4; 5:8; 9:12]

z =

     1     2     3     4
     5     6     7     8
     9    10    11    12

z(:,2) = [];
z

z =

     1     3     4
     5     7     8
     9    11    12

z (z>2) = 0;
z

z =

     1     0     0
     0     0     0
     0     0     0

j = x > 2

j =

  1×5 logical array

   0   0   1   1   1

 help plot

