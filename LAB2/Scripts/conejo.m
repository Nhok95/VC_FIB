clc;
clear all;
I = imread('Bird24b.bmp');
G = rgb2gray(I);

J = arrayfun(@myfunctionConejo, G);

imshow(J);
imcontrast