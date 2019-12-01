function [Parameters, Labels] = createData(Scan)

    i = 1;
    for imageIndex= 1:1521

        if( mod(imageIndex,100) == 0) 
            fprintf('%d\n', imageIndex);
        end

        %ejemplos positivos
        lx = Scan(imageIndex).lx; ly = Scan(imageIndex).ly;
        rx = Scan(imageIndex).rx; ry = Scan(imageIndex).ry;

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
        rect = imresize(rect, CONSTANTS.RECT_SIZE);

        featVector = extractHOGFeatures(rect,'CellSize',CONSTANTS.CELL_SIZE,...
            'BlockSize', CONSTANTS.CELL_BLOCK,'NumBins', 15);
        featVector = ((featVector - min(featVector)) / ( max(featVector) - min(featVector) ));
        %featVector = mean(featVector);
        
        %figure;
        %imshow(rect); 
        %hold on;
        %plot(hogV);
        
        %[H,theta,rho] = hough(rect);
        histVector = histcounts(rect, CONSTANTS.BINS); 
        histVector = ((histVector - min(histVector)) / ( max(histVector) - min(histVector) ));
        %histVector = mean(histVector);

        Parameters(i,:) = [featVector,histVector];
        Labels(i,:) = int8(CONSTANTS.TRUE_VALUE);

        %ejemplos negativos
        ii = 0;   
        for ii = (i+1):(i+CONSTANTS.FALSE_IMAGES_RATIO)
            [a,b,c,d] = getFalseEyeRect(I,yminrect,CONSTANTS.RECT_SIZE(2), CONSTANTS.RECT_SIZE(1));
            rect = imcrop(I, [a,b,c,d]);
            rect = imresize(rect, CONSTANTS.RECT_SIZE);
            
            featVector = extractHOGFeatures(rect,'CellSize',CONSTANTS.CELL_SIZE,...
            'BlockSize', CONSTANTS.CELL_BLOCK,'NumBins', 15);
            featVector = uint8((featVector - min(featVector)) / ( max(featVector) - min(featVector) ));
            %featVector = mean(featVector);

            histVector = histcounts(rect,CONSTANTS.BINS);
            histVector = uint8((histVector - min(histVector)) / ( max(histVector) - min(histVector) ));
            %histVector = mean(histVector);

            Parameters(ii,:) = [featVector,histVector];
            Labels(ii,:) = int8(CONSTANTS.FALSE_VALUE);

        end
        i = ii+1;

    end
    fprintf('\n');
end

