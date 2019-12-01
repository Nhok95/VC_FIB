% segmentar cèl·lules
I = imread('cellsegmentationcompetition.png');
[f,c] = size(I);
G = rgb2gray(I);
imshow(G,[]);

%Li donem color negre als píxels blancs del fons.
whitePixs = (G == 255);    %mascara
outer_whitePixs = whitePixs & ~imclearborder(whitePixs);
G(outer_whitePixs) = 0;    
%figure;imshow(BW);

%{
% Desaparece la mini celula
BW = G > 20;
O = imopen(BW, strel('disk',5)); 
%}

BW = G > 22;%     %Binaritzem
%figure;imshow(B);
O = imopen(BW, strel('octagon',3));   %Open per tractar de separar cèl·lules
%figure;imshow(O);
BW = imfill(O, 'holes');    %Omplim els forats que es puguin haber creat.
%figure;imshow(B);

B2 = not(BW);
%figure;imshow(B2);
TD = bwdist(B2,'euclidean');
%figure;imshow(TD,[]);
TD = -TD;
%figure;imshow(TD,[]);
TD(B2) = -Inf;
%figure;imshow(TD,[]);

TDF = medfilt2(TD);
for i=1:5
    TDF = medfilt2(TDF);
end

WS = watershed(TDF);
%RGB = label2rgb(WS);
%figure; imshow(WS);
%figure; imshow(RGB);

Edges = bwmorph(WS, 'remove');
Edges = imdilate(Edges, strel('diamond', 1));
Edges = uint8(Edges*255);
Zeros = zeros(f,c/3);                  % Construim una matriu de zeros (per crear la imatge RGB)
EdgesRGB = cat(3,Edges, Edges, Zeros); % Li donem color (groc)
%figure; imshow(EdgesRGB);

I = I + EdgesRGB;
figure; imshow(I);
