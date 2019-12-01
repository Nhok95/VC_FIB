function [labels] = readMiram()
    
    filename = char(strcat(pwd, {'\BD\Miram.xlsx'}));
    %fid = fopen(filename);
    sheet = 1;
    fileRange = 'E5:E1525';
    
    xlsxValues = int8(xlsread(filename,sheet,fileRange,'basic'));
    xlsxValues(xlsxValues == 0) = -1;
    for i = 1:length(xlsxValues)
        labels(i) = xlsxValues(i);
    end
    
end

