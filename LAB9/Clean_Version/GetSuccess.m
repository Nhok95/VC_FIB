function [Success] = GetSuccess(M)
    Success = 0;
    for i = 1:30
        Success = Success + M(i,i);
    end
end

