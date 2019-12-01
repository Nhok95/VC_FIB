function [ratio] = SimetriaVertical(BW, BBox)

    pixelsLeft = 0;
    pixelsRight = 0;
    
    xIni = uint32(BBox(2));
    yIni = uint32(BBox(1))-1;
    xSize = uint32(BBox(4))-1;
    ySize = uint32(BBox(3))-1;
    yMid = uint32(yIni + ySize/2);
    
    for i = xIni:(xIni+xSize)
        for j = yIni:(yIni+ySize)
            if(BW(i,j)==1 && j <= yMid) 
                pixelsLeft = pixelsLeft + 1;
            end
            
            if(BW(i,j)==1 && j > yMid) 
                pixelsRight = pixelsRight + 1;
            end
            
        end
    end

    ratio = pixelsLeft / pixelsRight;
end