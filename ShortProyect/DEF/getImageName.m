function [name] = getImageName(i)
    if i <10 
        s = 'BioID_000';
    elseif i < 100
        s = 'BioID_00';
    elseif i < 1000
        s = 'BioID_0';
    else 
        s = 'BioID_';
    end 
    name = strcat(s,num2str(i),{'.pgm'});
end

