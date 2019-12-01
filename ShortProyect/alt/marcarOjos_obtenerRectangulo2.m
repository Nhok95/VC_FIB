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

clear all;
clc;

%BDFolder = char(strcat(pwd, {'\BD'}));
%addpath(BDFolder);
fprintf('scanning images... \n');
scan = myscanfiles();
fprintf('generating data... \n');
indexNeg = 1;

NumberOfImages = 1521 * 20;
NumberOfFeatures = 360; % Features per image

XSIZE = 32;
YSIZE = 88;
cellSize = [16, 16];
bins = 15;

for i= 1:1521
    
    if( mod(i,100) == 0) 
        fprintf('%d\n', i);
    end
    
    %ejemplos positivos
    lx = scan(i).lx; ly = scan(i).ly;
    rx = scan(i).rx; ry = scan(i).ry;
    
    name = strcat({'BD\'},getImageName(i-1));
    I = imread(name{1});
    
    [xminrect,yminrect,width,height] = getEyeRect(I,lx,ly,rx,ry);
    
    if (xminrect == 0)
        xminrect = 1;
    end
    if (yminrect == 0)
        yminrect = 1;
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

    rect = imcrop(I, [xminrect, yminrect, width,height]);
    rect = imresize(rect, [XSIZE, YSIZE]);
    
    featVector = extractHOGFeatures(rect,'CellSize',cellSize,'NumBins', 15);
    histVector = histcounts(rect,bins); 
    
    %featMean = mean(featVector);
    %imshow(rect); 
    %hold on;
    %plot(hog);
    
    %posValues(i).name = char(name);
    %posValues(i).x = xminrect;
    %posValues(i).y = yminrect;
    %posValues(i).width = width;
    %posValues(i).height = height;
    
    X1(i,:) = [featVector,histVector];
    %posValues(i).featVector =featVector;
    %posValues(i).featVector = featMean;
    %posValues(i).eye = int8(1);
    Y1(i,:) = int8(1);
    
    
    %visualització
    %rectangle = imcrop(I, [x,y,xsize,ysize]);
    %rectangle2 = imresize(rectangle, [XSIZE, YSIZE]);
    %figure; imshow(rectangle2);
    
    %ejemplos negativos
    
    for ii = 1:19
        [a,b,c,d] = getFalseEyeRect(I,yminrect,XSIZE, YSIZE);
        rect = imcrop(I, [a,b,c,d]);
        rect = imresize(rect, [XSIZE, YSIZE]);
        featVector = extractHOGFeatures(rect,'CellSize',cellSize,'NumBins', 15);
        histVector = histcounts(rect,bins); 
        X2(indexNeg,:) = [featVector, histVector];
        Y2(indexNeg,:) = int8(-1);
        indexNeg = indexNeg + 1;
    end
    
end

%data = [posValues, negValues];
X = [X1; X2];
Y = [Y1; Y2];

[predictor, cmat] = crearPredictor(X,Y);
%predictor = fitcsvm(X,Y,'Standardize',true,'KernelFunction','rbf','ClassNames',[-1,1]);
%yp = int8(predict(predictor,X));
%C = confusionmat(y,yp);
%confusionchart(y,yp);


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






