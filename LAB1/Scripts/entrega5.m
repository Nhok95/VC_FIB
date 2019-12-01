x = -5:0.1:5;
y = -5:0.1:5;

for i=1:length(x)
    for j=1:length(y)
        u = x(i);
        w = y(j);
        f(i,j) = function5(u,w);
    end
end

levels= 0:1:100;
func = @(x) (x(1)^2+x(2)-5)^2 + (x(1)+x(2)^2-9)^2;
subplot(1,2,2);contour(x,y,f,levels)
grid on
subplot(1,2,1);surf(x,y,f)

[xymin1 value1] = fminsearch(func,[1.5;2.6])
[xymin2 value2] = fminsearch(func,[-1.6,3.3])
[xymin3 value3] = fminsearch(func,[2.9;-2.5])
[xymin4 value4] = fminsearch(func,[-2.9;-3.5])

