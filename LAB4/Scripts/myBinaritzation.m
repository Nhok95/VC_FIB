function [BW] = myBinaritzation( I, alpha )
%alpha: 0:= min ndg I,  max ndg I

Imax = max(max(I));
Imin = min(min(I));

lambda = alpha*(Imax-Imin)+Imin;

BW = I > lambda;
imshow(BW,[]);


end

