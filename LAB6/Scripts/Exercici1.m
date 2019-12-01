%Nombre de dents; pista:120 dents
clc;
I = imread('wheel.bmp');
BW = rgb2gray(I);
B = BW > 1;

F = imfill(B,'holes');
imshow(F);

radi = 15;
SE = strel('disk', radi);
E = imerode(F, SE); %erosionem la imatge F

radi2 = 16;
SE2 = strel('disk', radi2);
C = imdilate(E, SE2);
figure;imshow(C);

NF = F& (not(C));
figure;imshow(NF);

CC = bwconncomp(NF); 

Res = CC.NumObjects;
