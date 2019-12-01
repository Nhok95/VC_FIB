%inventem una funcio de binarització

I = imread('money.tif');

alpha = 0.5;

BW = myBinaritzation(I, alpha);

imshow(BW);