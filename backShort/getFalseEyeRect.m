function [xmin, ymin, xsize, ysize] = getFalseEyeRect(I,yminrect,XSIZE,YSIZE)
    
    [imX, imY] = size(I);
    
    xsize = XSIZE;
    ysize = YSIZE; 

    % cantonada superior esquerra
    xmin = uint32(rand * (imY - xsize - 20 ));
    ymin = uint32(rand * (imX - ysize - 20));
    
    %comprobar Y
    while( (ymin >= (yminrect-32) && ymin <= (yminrect+32)))
        ymin = uint32(rand * (imX - ysize - 20));
    end  

end