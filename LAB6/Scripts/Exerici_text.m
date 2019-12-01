%conservar els pals del text
clc;
I = imread('text.tif');
B = I > 120;
imshow(B);

SE = strel('line', 9,90);
E = imerode(B, SE);
figure;imshow(E);

IR = imreconstruct(E, B);
figure;imshow(IR);