v = 0: 2*pi/30: 2*pi;
cv =(-cos (v));
cv (cv < 0) = 0;
plot (v,cv)
axis([0 6 0 1]);