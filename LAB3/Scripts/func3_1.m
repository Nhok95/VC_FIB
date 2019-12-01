function [Res] = func3_1(I)
    [nRows, nCols] = size(I);
    Res = I;

    for i = 3:nRows-3          
        auxS = sum(I(i, 1:5));        
        for j = 3:nCols-3
            auxS2 = sum(I(i-2:i+2, j));
            Res(i,j) = auxS+auxS2;
            auxS = auxS - I(i, j-2) + I(i, j+3);  
        end
      
    end 
    
end