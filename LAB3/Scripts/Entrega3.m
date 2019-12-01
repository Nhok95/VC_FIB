%3 J = I + C;
clc
clear all;

I = imread('car1.jpg');
G = rgb2gray(I);
figure;imshow(G);
%DG = double(G);

H = [-1,-2,-1;0,0,0;1,2,1];

GX = imfilter(G,H);
GY = imfilter(G,H');
%figure;imshow(J,[]);

C = abs(GX)+abs(GY);


Res = G + C;
figure;imshow(Res,[]);