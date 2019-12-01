%2 arrayfunction si blac filtro, si negre filtro, si no guay
clc
clear all;

I = imread('Bird24b.bmp');
G = rgb2gray(I);
figure;imshow(G);


imN = imnoise(G,'salt & pepper', 0.2);
figure;imshow(imN);

J = Anti_sp(imN); %J = colfilt(imN,[3 3],'sliding',@Anti_sp);
figure;imshow(J,[]);

