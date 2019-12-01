%Cèl·lula aïllada

%truco usar shrink + skiz + transformada distancia + buscar maxim
clc;
I = imread('normal-blood1.jpg');
BW = rgb2gray(I);
B = BW < 180;

F = imfill(B,'holes');

[sX sY] = size(B);

M = zeros(size(B));
M(:,1) = 1; M(1,:) = 1;
M(:,sY) = 1; M(sX,:) = 1;
M = logical(M);

IR = imreconstruct(M, F);

NF = F& (not(IR));

CC = bwconncomp(NF); 
Res = CC.NumObjects;

R = regionprops(CC, 'centroid');
centroids = cat(1, R.Centroid);
%figure;imshow(NF);
%hold on;
%plot(centroids(:,1),centroids(:,2), 'b*');
%hold off;

%%%%Start here

DT = bwdist(NF, 'euclidean');
figure;imshow(DT,[]);
DL = watershed(DT);
%figure; imshow(DL);
bgm = DL == 0;
figure;imshow(bgm);
hold on;
plot(centroids(:,1),centroids(:,2), 'b*');
hold off;

DT2 = bwdist(bgm, 'euclidean'); %Dist a les fronteres
figure;imshow(DT2,[]);

max = 0.0;
maxCoord = [0 0];
for i=1:28
    y = int16(centroids(i,1));
    x = int16(centroids(i,2));
    value = double(DT2(x,y));
    if value > max
        max = value;
        maxCoord = [centroids(i,1), centroids(i,2)];
    end
end

figure;imshow(NF);
hold on;
plot(maxCoord(1,1),maxCoord(1,2), 'b*');
hold off;

