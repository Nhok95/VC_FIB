function [ratio] = SimetriaHoritzontal(BW, BBox)

    pixelsUp = 0;
    pixelsDown = 0;
    
    xIni = uint32(BBox(2));
    yIni = uint32(BBox(1))-1;
    xSize = uint32(BBox(4))-1;
    ySize = uint32(BBox(3))-1;
    xMid = uint32(xIni + xSize/2);
    
    for i = xIni:(xIni+xSize)
        for j = yIni:(yIni+ySize)
            if(BW(i,j)==1 && i <= xMid) 
                pixelsUp = pixelsUp + 1;
            end
            
            if(BW(i,j)==1 && i > xMid) 
                pixelsDown = pixelsDown + 1;
            end
            
        end
    end

    ratio = pixelsUp / pixelsDown;

end