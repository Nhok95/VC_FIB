function length = findLargestVerticalLine(BW, BBox)

    length = 0;
    
    yIni = uint32(BBox(1));
    xIni = uint32(BBox(2));
    ySize = yIni+uint32(BBox(3));
    xSize = xIni+uint32(BBox(4));
    
    for j = yIni:ySize
        lineLength = 0;
        for i = xIni:xSize
            if(BW(i,j)==1) 
                lineLength = lineLength + 1;
            end
        end
        if(lineLength > length) 
            length = lineLength;
        end
    end


end