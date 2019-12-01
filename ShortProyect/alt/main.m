clear all;
clc;

fprintf('scanning images... \n');
scan = myscanfiles();
fprintf('generating data... \n');
indexNeg = 1;

NumberOfImages = 1521 * 20;
NumberOfFeatures = 360; % Features per image

XSIZE = 32;
YSIZE = 88;
cellSize = [12, 12];
 
%Parameters = double.empty(NumberOfImages,NumberOfFeatures, 0);
%Labels = double.empty(NumberOfImages,0);

Parameters = zeros(NumberOfImages,NumberOfFeatures);
Labels = zeros(NumberOfImages,1);
i = 1;

for imageIndex= 1:1521
    
    if( mod(imageIndex,100) == 0) 
        fprintf('%d\n', imageIndex);
    end
    
    %ejemplos positivos
    lx = scan(imageIndex).lx; ly = scan(imageIndex).ly;
    rx = scan(imageIndex).rx; ry = scan(imageIndex).ry;
    
    name = strcat({'BD\'},getImageName(imageIndex-1));
    I = imread(name{1});
    
    [xminrect,yminrect,width,height] = getEyeRect(I,lx,ly,rx,ry);
    
    if (xminrect == 0)
        xminrect = 1;
    end
    if (yminrect == 0)
        yminrect = 1;
    end
    
    rect = imcrop(I, [xminrect, yminrect, width,height]);
    rect = imresize(rect, [XSIZE, YSIZE]);
        
    featVector = extractHOGFeatures(rect,'CellSize',cellSize,'NumBins', 15);

    Parameters(i,:) = featVector;
    Labels(i) = int8(1);


    ii = 0;   
    for ii = (i+1):(i+19)
        [a,b,c,d] = getFalseEyeRect(I,yminrect,XSIZE, YSIZE);
        rect = imcrop(I, [a,b,c,d]);
        rect = imresize(rect, [XSIZE, YSIZE]);
        featVector = extractHOGFeatures(rect,'CellSize',cellSize,'NumBins', 15);

        Parameters(ii,:) = featVector;
        Labels(ii) = int8(-1);
        
    end
    i = ii+1;
end

predictor = fitcsvm(Parameters,Labels,'KernelFunction','rbf','ClassNames',[-1,1]);

LabelsPredicted = int8(predict(predictor,Parameters));
errors = abs(int8(Labels)-LabelsPredicted);
sum(errors)/2

