function [length] = findLargestHorizontalLine(BW, BBox)
    length = 0;

    yIni = uint32(BBox(1));
    xIni = uint32(BBox(2));
    ySize = yIni+uint32(BBox(3));
    xSize = xIni+uint32(BBox(4));
    
    for i = xIni:xSize
        lineLength = 0;
        for j = yIni:ySize
            if(BW(i,j)==1) 
                lineLength = lineLength + 1;
            end
        end
        
        if(lineLength > length)
            length = lineLength;
        end
    end
        
end