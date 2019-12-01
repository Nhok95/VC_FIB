%4 H = [0,0,0;0,1,1;0,0,0] rotar per fer totes direccions
% imrotate
clc;
clear all;

I = imread('Bird24b.bmp');
G = rgb2gray(I);
imshow(G);

G = double(G);

Res = myMotion(G,40,135);
figure;imshow(Res,[]);

%{
MB = fspecial('motion',40,135);
MotionBlur = imfilter(G,MB,'replicate');

figure;imshow(MotionBlur, []);
%}
