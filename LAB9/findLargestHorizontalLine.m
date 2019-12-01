function length = findLargestHorizontalLine(BW, BBox)
    %c = 0;
    length = 0;
    %pseudomax = 0;
    
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
        %{
        if (lineLength == pseudomax & c <2)
            c = c+1;
        elseif (lineLength == pseudomax & c==2)    
            length = lineLength;
            pseudomax=0; c=0;
        elseif(lineLength > length) 
            pseudomax = lineLength;
            c = 1;
        elseif (lineLength < pseudomax)
            pseudomax =0; c=0;
        end
        %}
        if(lineLength > length)
            length = lineLength;
        end
    end
        
end