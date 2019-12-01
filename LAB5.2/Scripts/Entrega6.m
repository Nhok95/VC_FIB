% Volem obtenir el centroide del gat.
clc;
clear all;
% segmentacio per nivell de gris utilitzant Graph Cut
[file,path] = uigetfile('*.*'); % obre l'explorador d'arxius
I = imread(fullfile(path,file));
Indg = rgb2gray(I);

[Selected,rect]= Select(Indg);

hfore = imhist(Selected);
hback = imhist(Indg);
%plot(hfore);
%figure;plot(hback);

Is = Fragmentacio(Indg, hback, hfore);
%figure;imshow(Is,[]);

%C = bwconncomp(Is);
%imshow(Is,[]);

S = regionprops(Is,'centroid');
centroids = cat(1, S.Centroid);

[centrX, centrY] = getCentroideCentral(centroids);

circleCentroid = [centrX, centrY, 3];

Final = insertShape(Is,'circle', circleCentroid,'LineWidth',2); 
figure;imshow(Final,[]);
