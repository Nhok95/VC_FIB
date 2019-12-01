% segmentar celules

I = imread('cellsegmentationcompetition.png');
[f,c] = size(I);

BW = rgb2gray(I);
%imshow(BW,[]);

whitePixs = (BW == 255);
%otherPixs = ~whitePixs;
outer_whitePixs = whitePixs & ~imclearborder(whitePixs);
BW(outer_whitePixs) = 0;

figure;imshow(BW);


B = BW > 20;
figure;imshow(B);

O = imopen(B, strel('disk',5));
figure;imshow(O);

B = imfill(O, 'holes');
figure;imshow(B);

%{
CC = bwconncomp(B); 
R = regionprops(CC, 'centroid');
centroids = cat(1, R.Centroid);
figure;imshow(O);
hold on;
plot(centroids(:,1),centroids(:,2), 'b*');
hold off;
%}


%M = imregionalmax(O);
%IS = B + uint8(M)*255;
%figure; imshow(IS,[]);

%Canny = edge(B,'canny',[0.3, 0.6]);
%figure;imshow(Canny);

B2 = not(B);
%figure;imshow(B2);


TD = bwdist(B2,'euclidean');
%figure;imshow(TD,[]);
TD = -TD;
%figure;imshow(TD,[]);
TD(B2) = -Inf;
%figure;imshow(TD,[]);

TDF = medfilt2(TD);
TDF = medfilt2(TDF);
TDF = medfilt2(TDF);
TDF = medfilt2(TDF);
TDF = medfilt2(TDF);
TDF = medfilt2(TDF);

WS = watershed(TDF);
RGB = label2rgb(WS);
%figure; imshow(WS);
figure; imshow(RGB);

Edges = bwmorph(WS, 'remove');
Edges = imdilate(Edges, strel('disk', 1));
Edges = uint8(Edges*255);
Zeros = zeros(f,c/3);
Edges = cat(3,Edges, Edges, Zeros); %li donem color (groc)
figure; imshow(Edges);

I = I + Edges;
figure; imshow(I);

%{

G = rgb2gray(RGB);
figure; imshow(G);
%}

