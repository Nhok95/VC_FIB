classdef CONSTANTS
   
    properties (Constant)
      RECT_SIZE = [32, 88];
      CROP_SIZE = [88, 32];
      CELL_SIZE = [12,12];
      CELL_SIZE2 = [7,7];
      CELL_BLOCK = [2,2];
      BINS = 30;
      FALSE_IMAGES_RATIO = 19; %19 = 95% no eye / 5% eye
      SPLIT_RATIO = 0.7; % 0.7 = 70% Training / 30% Test
      TRUE_VALUE = 1;
      FALSE_VALUE = -1;
      SCALE = [286,384];
      KFOLD = 5;
    end

end

