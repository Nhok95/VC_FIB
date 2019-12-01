%Cèl·lules vermelles
clc;
I = imread('normal-blood1.jpg');
BW = rgb2gray(I);
%imshow(BW);
B = BW < 180;
%figure;imshow(B);

F = imfill(B,'holes');
%figure;imshow(F);

[sX sY] = size(B);

M = zeros(size(B));
M(:,1) = 1; M(1,:) = 1;
M(:,sY) = 1; M(sX,:) = 1;
M = logical(M);

IR = imreconstruct(M, F);
%figure; imshow(IR);

NF = F& (not(IR));
figure; imshow(NF);

CC = bwconncomp(NF); 
Res = CC.NumObjects;

R = regionprops(CC, 'centroid');
centroids = cat(1, R.Centroid);
figure;imshow(NF);
hold on;
plot(centroids(:,1),centroids(:,2), 'b*');
hold off;







