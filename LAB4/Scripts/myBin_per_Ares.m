function [csum] = myBin_per_Ares(I, A)
%
h = imhist(I);
%plot(h);

csum = cumsum(h);

lambda = find(csum>A,1);
BW = I > lambda;

imshow(BW,[]);

%plot(csum);
end

