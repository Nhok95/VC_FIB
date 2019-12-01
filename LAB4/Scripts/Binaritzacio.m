clc;
clear all;
%Binarització
%{
I = imread('money.tif');
%imshow(I);

h = imhist(I);
%plot(h);

BW = I > 64;
%figure;imshow (BW,[]);

Tresh = graythresh(I);  %0 <=Tresh <= 1

BWOtsu = I > Tresh*256;
%figure;imshow(BWOtsu,[]);
%}

%%%%%%%%%%%%
%{
I = imread('Enters manuscrits 1.jpg');
%imshow(I);
G = rgb2gray(I);
%h = imhist(G);
%plot(h);
BWOtsu2 = I > Tresh*256;
%figure;imshow(BWOtsu2,[]);



%Midnight = (230/360, 50/100, 22/100); %Midnight color
HSV = rgb2hsv(I);
imshow(HSV);
%hsv_hist = imhist(G);
%plot(hsv_hist);

Dist = (230/360.0 - HSV(:,:,1)).^2 + (50/100.0 - HSV(:,:,2)).^2 + (22/100.0 - HSV(:,:,3)).^2;
%dist_hist = imhist(Dist);
%plot(dist_hist);        

%figure;imshow(Dist,[]);
BW_hsv = Dist < 0.25;
%figure;imshow(BW_hsv);
%}



%%%%%%%%%%%%%%%
%{
I = imread('calc.tif');
%imshow(I);
h_calc = imhist(I);

mth = multithresh(I,2); %N+1 agrupacions

I = imquantize(I,mth);

imshow(I,[]);
%}

%%%%%%%%%%%%%%%
%{
I = imread('calc.tif');

hv = fspecial('sobel');
hh = hv';

Gx = imfilter(I,hv);

Gy = imfilter(I,hh);

G = abs(Gx)+abs(Gy);

G_hist = imhist(G);
plot(G_hist);

BWsobel = G >250;

figure;imshow(BWsobel,[]);
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I = imread('calc.tif');
Canny = edge(I,'canny',[0.3, 0.7]); %edge(Image, method, [Ti, Th])
Sobel = edge(I,'sobel');
Log = edge(I,'log');

imshow(Canny,[]);
figure;imshow(Sobel,[]);
figure;imshow(Log,[]);

