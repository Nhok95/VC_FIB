clc;
clear all;
I = imread('tesla-cat.jpg');
I2 = rgb2gray(I);
BW = im2bw(I,95/255);
%simshow(BW);

C = bwconncomp(BW);

J = I2;
J(C.PixelIdxList{1}) = 100;
imshow(J,[]);
np = cellfun(@numel,C.PixelIdxList);

[v, index] = max(np);

J(C.PixelIdxList{index}) = 255;
B = zeros(size(I));
B(C.PixelIdxList{index}) = 1;  %mascara
%imshow(B,[]);

NI = I + 64*uint8(B); %aclarim la moneda de la mascara
%imshow(I);
%figure;imshow(NI,[]);

S = regionprops(C,'centroid', 'BoundingBox');
S.BoundingBox;


%%%%% K-means

K = kmeans(double(I(:)),2);
Ic = reshape(K,size(I));
%imshow(I);
%figure;imshow(Ic,[]);

I = imread('money.tif');
imshow(I);
rect = getrect()


