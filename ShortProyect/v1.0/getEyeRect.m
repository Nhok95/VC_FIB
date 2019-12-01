function [xmin, ymin, xsize, ysize] = getEyeRect(I,lx,ly,rx,ry)
   
    [imX, imY] = size(I);
    
    widthOriginal = lx - rx;
    WidthRectangle = 1.6*widthOriginal; %1.9*widthOriginal;
    difX = (WidthRectangle-widthOriginal)/2; % el que afegim a cada costat
    difY = widthOriginal*0.25; % el que afegim a dalt i a baix
    %difY = difX * 0.5; % el que afegim a dalt i a baix

    %cantonada superior esquerra del rectangle
    
    xmin = max(0,rx - difX); ymin = max(0,min(ly,ry) - difY); 
    
    %cantonada inferior dreta del rectangle
    xmax = min(imX,lx + difX); ymax = min(imY,max(ly,ry) + difY);
    
    %RGB = insertShape(I,'circle',[xmin ymin 5],'LineWidth',2);
    %imshow(RGB);
    
    xsize = xmax - xmin; ysize = ymax - ymin;
end

