x = -15:1:15;
[X,Y] = meshgrid(x, x);

f = (2*pi)/(30*sqrt(2));

Z = cos((sqrt(X.^2+Y.^2))*f);

Z (Z < 0) = 0;

colormap(hot);
surf(X,Y,Z);
axis([-15 15 -15 15 0 2 ]);