function [xmin, ymin, xsize, ysize] = getEyeRect(I,lx,ly,rx,ry)
   
    [imX, imY] = size(I);
    
    widthOriginal = lx - rx;
    WidthRectangle = 1.6*widthOriginal; 
    difX = (WidthRectangle-widthOriginal)/2; % horizontal margin
    difY = widthOriginal*0.25; % vertical margin
    
    % top-left corner of the rectangle
    
    xmin = max(0,rx - difX); ymin = max(0,min(ly,ry) - difY); 
    
    % down-right corner of the rectangle
    xmax = min(imX,lx + difX); ymax = min(imY,max(ly,ry) + difY);
      
    xsize = xmax - xmin; ysize = ymax - ymin;
end

