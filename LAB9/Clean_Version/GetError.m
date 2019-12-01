function [Error] = GetError(M)
    Error = 0;
    for i = 1:29
        for j = i+1:30
            Error = Error + M(i,j)+M(j,i);
        end
    end
end

