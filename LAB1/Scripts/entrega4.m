x = -15:1:15;
[X0,Y0] = meshgrid(x, x);

f = (2*pi)/(30*sqrt(2));

Z = cos((sqrt(X0.^2+Y0.^2))*f);

Z (Z < 0) = 0;

X1 = X0+15;
Y1 = Y0+15;

X2 = X0+15;
Y2 = Y0-15;

XX = [X1;X2];
YY = [Y1;Y2];
Z = [Z;Z];

XX2 = XX-30;

X = [XX;XX2];
Y = [YY;YY];
Z = [Z;Z];

colormap(jet);
surf(X,Y,Z);
axis([-30 30 -30 30 0 1.5 ]);