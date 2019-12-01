classdef CONSTANTS
   
    properties (Constant)
      RECT_SIZE = [32, 88];
      CROP_SIZE = [88, 32];
      CELL_SIZE = [12,12]; 
      CELL_BLOCK = [2,2];
      BINS = 20;
      FALSE_IMAGES_RATIO = 19; %19 = 95% no eye
      RATIO_CV_DATA = 0.75;
      TRUE_VALUE = 1;
      FALSE_VALUE = -1;
      %SCALEX = 320;
      SCALE = [286,384];
      KFOLD = 5;
   end

end

