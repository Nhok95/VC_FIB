function [Parameters] = createData2(Scan)
    for imageIndex= 1:1521

        if( mod(imageIndex,100) == 0) 
            fprintf('%d  ', imageIndex);
        end
        
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

        featVector = extractHOGFeatures(rect,'CellSize',CONSTANTS.CELL_SIZE2,...
            'BlockSize', CONSTANTS.CELL_BLOCK,'NumBins', 15);
        featVector = ((featVector - min(featVector)) / ( max(featVector) - min(featVector) ));
        
        [mag, ~] = imgaborfilt(rect,2,0);
        %histVector = histcounts(rect, CONSTANTS.BINS); 
        %histVector = ((histVector - min(histVector)) / ( max(histVector) - min(histVector) ))+1;
        magVector = mean(mag); 
        magVector = ((magVector - min(magVector)) / ( max(magVector) - min(magVector) ))+1;
        Parameters(imageIndex,:) = [featVector,magVector];

    end
    fprintf('\n');
end

