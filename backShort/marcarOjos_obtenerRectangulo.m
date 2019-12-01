%
% Matriu d'observacio X
%     |X1  ...  Xn 
%     |X1  ...  Xn
%     |
% 1500|
%     |
%     |
%     |
%     |
%
% 3 scripts 
%     predictor
%     mesurar l'efectividad del predictor     
%     fer servir predictor amb ims reals
%
% guardem posicions (no imatges)
% 
%

%img = imread('cameraman.tif');
%img = imread('Building.bmp');
%img = imread('CD.bmp'); 
%img = imread('Chess figures.png');

%[featureVector,hogVisualization] = extractHOGFeatures(img);

%figure;
%imshow(img); 
%hold on;
%plot(hogVisualization);

%{
a = dir('I:/vc/Short Project/BioID_0177.eye');

filename = horzcat(a(1).folder,'/',a(1).name);

fid = fopen(filename);
s = textscan(fid, '%s', 1, 'delimiter', '\n');
c = textscan(fid, '%d', 4, 'delimiter', ' ');
lx = c{1}(1);ly = c{1}(2);rx = c{1}(3);ry = c{1}(4);

fclose(fid);
%}

clc;

BDFolder = char(strcat(pwd, {'\BD'}));
addpath(BDFolder);

scan = myscanfiles;

for i= 1:1521
    %ejemplos positivos
    lx = scan(i).lx; ly = scan(i).ly;
    rx = scan(i).rx; ry = scan(i).ry;
    
    name = getImageName(i-1);
    I = imread(name{1});
    
    [x,y,width,height] = getEyeRect(I,lx,ly,rx,ry);
    
    if (x == 0)
        x = 1;
    end
    if (y == 0)
        y = 1;
    end
    
    %getPixels (no se pa k pero a lo mejor sirve)
    
%     pixelsList = [];
%     ind = 1;
%     for k = y:(y+height-1)
%         for l = x:(x+width-1)
%             pixelsList(ind) = I(k,l);
%             ind = ind+1;
%         end
%     end
    rect = imcrop(I, [x, y, width,height]);
    rect = imresize(rect, [32 88]);
    
    [featVector,hog] = extractHOGFeatures(rect,'CellSize',[2 2],'NumBins', 15);
    
    imshow(rect); 
    hold on;
    plot(hog);
    
    posValues(i).name = char(name);
    posValues(i).x = x;
    posValues(i).y = y;
    posValues(i).width = width;
    posValues(i).height = height;
    posValues(i).eye = 1;
    
    %visualització
    %rectangle = imcrop(I, [x,y,xsize,ysize]);
    %rectangle2 = imresize(rectangle, [32 88]);
    %figure; imshow(rectangle2);
    
    %ejemplos negativos
    % :P
    
    
end

predictor = crearPredictor(posValues);

% MARCAR LOS OJOS:
%{
n = 1;
lx = scan(n).lx; ly = scan(n).ly;
rx = scan(n).rx; ry = scan(n).ry;

I = imread('BioID_0000.pgm');  %n-1
imshow(I);
[imX imY] = size(I);

RGB = insertShape(I,'circle',[lx ly 5],'LineWidth',1);
RGB = insertShape(RGB,'circle',[rx ry 5],'LineWidth',1);

%imshow(RGB);

% OBTENER PARTE DEL ROSTRO QUE ENVUELVE LOS OJOS
d = lx - rx;
D = 1.6*d; 
difX = (D-d)/2;
difY = d*0.25;

xmin = max(0,rx - difX);
ymin = max(0,ry - difY);
xmax = min(imX,lx + difX);
ymax = min(imY,ly + difY);

xsize = xmax - xmin;
ysize = ymax - ymin;

rectangle = imcrop(RGB, [xmin, ymin, xsize, ysize]);
rectangle2 = imresize(rectangle, [32 88]);

figure; imshow(rectangle);
%}






