clc;
clear all;
%Filtrat d'imatge
I = imread('football.jpg');
I = rgb2gray(I);
%imshow(I);
D = 0.1;
M = 0;
V = 0.1;
J = imnoise(I,'salt & pepper', D);
%J = imnoise(I,'gaussian', M,V);
%imshow(J);

%Filtrat de suavitat, passa baixos.
H = [1,1,1;1,1,1;1,1,1];
%H = 1/9*[1,1,1;1,1,1;1,1,1]; %promig
%I = double(I);
%Q = imfilter(I,H);
%imshow(Q,[]);

%H = fspecial(Tipus de filtre, parametre);

H = fspecial('average', [64 64]); %par = size;
%H = fspecial('disk', 10); %par = radi;
%H = fspecial('gaussian', [64 64], 0.2); % par = size, sigma;

%Q = imfilter(I,H);
%imshow(Q,[])

%Filtres de passa alts, derivatius
%%%Laplacia
H = [-1,-1,-1;-1,8,-1;-1,-1,-1];

%J = imfilter(I,H);
%imshow(J,[]);

%%%Sobel
H = [-1,-2,-1;0,0,0;1,2,1];
%J = imfilter(I,H);
%imshow(J,[]);

%Aplicar una funcion a una imatge.
%%% J = arrayfunction(@myfunction,I);

%%per obtenir els pixels veins
%%% J = colfilt(I,[f c], 'sliding',@myfunction);[f c] es la mida de la finestra d'analisis.

JJ = colfilt(J,[3 3],'sliding',@myfunction);
imshow(JJ);