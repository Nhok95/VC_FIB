function [ Res ] = Anti_sp( I )   
%asumim 3x3
%{
if x(5) == 0 | x(5) == 255
    y = mean(x)
end
%}
[nRows, nCols] = size(I);
Res = I;
    for i = 3:nRows-2        
        for j = 3:nCols-2
            if I(i,j) == 0 | I(i,j) == 255
                window = [I(i-1,j-1),I(i-1,j),I(i,j+1),I(i,j-1),I(i,j),I(i,j+1),I(i+1,j-1),I(i+1,j),I(i+1,j+1)];
                Res(i,j) = median(window);
            end
        end
      
    end 

end

