function [ y ] = myfunctionConejo(ndg)
y = uint8(200*exp(-300/(double(ndg)-100)));
%y = uint8(500*exp(-50/(double(ndg)-60)));
end

