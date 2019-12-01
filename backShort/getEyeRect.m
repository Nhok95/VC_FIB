function [xmin, ymin, xsize, ysize] = getEyeRect(I,lx,ly,rx,ry)
    [imX imY] = size(I);
    
    d = lx - rx;
    D = 1.6*d; 
    difX = (D-d)/2;
    difY = d*0.25;

    xmin = max(0,rx - difX); ymin = max(0,ry - difY);
    xmax = min(imX,lx + difX); ymax = min(imY,ly + difY);
    
    %RGB = insertShape(I,'circle',[xmin ymin 5],'LineWidth',2);
    %imshow(RGB);
    
    xsize = xmax - xmin; ysize = ymax - ymin;
end

