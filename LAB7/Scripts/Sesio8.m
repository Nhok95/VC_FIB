%tophat
I = imread('rice.png');
%imshow(I);

CELLSIZE = 10;
SE = strel('disk', CELLSIZE);
IF = imtophat(I,SE);
%figure; imshow(IF,[]);


%
O = imopen(IF, strel('disk',5));
C = imclose(IF, strel('disk',5));

%figure; imshow(O,[]);
%figure; imshow(C,[]);

%O ha d'estar filtrada
M = imregionalmax(O); % 1 els pixels que corresponen a un max local.
%M = imregionalmax(I);

IS = I + uint8(M)*255;
figure; imshow(IS,[]);


%watershed
%separar coses

BW = O > 8;
figure; imshow(BW);

B = not(BW);
figure; imshow(B);

TD = bwdist(B,'euclidean');
TD = -TD;
TD(B) = -Inf;
figure;imshow(TD,[]);

TDF = medfilt2(TD); %filtrem per evitar sobresegmentació.
TDF = medfilt2(TDF);
TDF = medfilt2(TDF);
TDF = medfilt2(TDF);
TDF = medfilt2(TDF);
TDF = medfilt2(TDF);
TDF = medfilt2(TDF);

WS = watershed(TDF);
RGB = label2rgb(WS);
figure; imshow(RGB);

