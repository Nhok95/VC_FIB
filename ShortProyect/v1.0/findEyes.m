function [ veredict ] = findEyes(I, predictor)
    
    %%%% CONSTANTS
    IMG_SIZE = size(I);
    SKIPX = 5;
    SKIPY = 5;
    CROP_SCALES = [150, 200]; 
    LIMITX = IMG_SIZE(2) - CONSTANTS.RECT_SIZE(2);
    LIMITY = IMG_SIZE(1) - CONSTANTS.RECT_SIZE(1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    veredict = CONSTANTS.FALSE_VALUE;
    for cropScale = CROP_SCALES
        if(veredict ~= CONSTANTS.TRUE_VALUE) 
            for coordx = 1:SKIPX:LIMITX
               if(veredict ~= CONSTANTS.TRUE_VALUE) 
                   for coordy = 1:SKIPY:LIMITY
                       if(veredict ~= CONSTANTS.TRUE_VALUE)
                           crop = uint32(CONSTANTS.CROP_SIZE * cropScale/100);
                           rect = imcrop(I, [coordx, coordy, crop]);
                           rect = imresize(rect, CONSTANTS.RECT_SIZE);
                           
                           featVector = extractHOGFeatures(rect,'CellSize',CONSTANTS.CELL_SIZE,...
                            'BlockSize', CONSTANTS.CELL_BLOCK,'NumBins', 15);
                           featVector = ((featVector - min(featVector)) / (max(featVector) - min(featVector)));
                           %featVector = mean(featVector);
                           
                           %figure;
                           %imshow(rect); 
                           %hold on;
                           %plot(hogV);
        
                           histVector = histcounts(rect,CONSTANTS.BINS); 
                           histVector = ((histVector - min(histVector)) / (max(histVector) - min(histVector)));
                           %histVector = mean(histVector);

                           Parameters = [featVector,histVector];
                           
                           veredict = int8(predict(predictor, Parameters)); %%% find eyes?
                           if(veredict == 1)
                               imshow(I); hold on
                               rectangle('Position',[coordx,coordy,crop],'LineWidth',2);
                               hold off
                           end
                       end
                   end
               end
            end
        end
    end
end