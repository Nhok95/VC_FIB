%1 H = [1,1,1;1,1,1;1,1,1] = [1,1,1]*[1;1;1];
clc
clear all;

I = imread('Bird24b.bmp');
G = rgb2gray(I);
imshow(G);

G = double(G);
%{
H = 1/25*[1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1];
tic
J = imfilter(G,H);
toc
figure; imshow(J, []);
%}

out = func3_1(G);
figure;imshow(out,[]);
