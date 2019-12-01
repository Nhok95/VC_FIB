%Operadors morfologics
%%%sang
clc;
I = imread('blood5.tif');
B = I < 128;
F = imfill(B,'holes');
%imshow(F);

radi = 6;
SE = strel('disk', radi);
E = imerode(F, SE); %erosionem la imatge F
%figure;imshow(E);

E = imerode(E, SE); %apliquem una altra erosio
%figure;imshow(E);

%%% cafe
I = imread('cafe.tif');
B = I < 16; 
%imshow(B);
radi2 = 8;
SE2 = strel('disk', radi2);
E = imerode(B,SE2);
%figure;imshow(E);


%%% cafe2
%B -> 1-B o not(B)
DT = bwdist(not(B), 'euclidean');  % transformada de la distancia
%figure;imshow(DT,[]);

M = max(max(DT));

C = DT > 10;  %mostra només els objectes amb valors superiors a 10;
%figure;imshow(C,[]);

CC = bwconncomp(C); 
R = regionprops(CC, 'centroid');

NC = bwmorph(C, 'shrink', Inf); %erosionem fins arriba a 1 pixel.
%figure; imshow(NC,[]);


