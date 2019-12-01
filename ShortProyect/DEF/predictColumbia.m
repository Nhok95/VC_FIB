function [newDB] = readColumbiaDir()
    BDfolder = char(strcat(pwd, {'\BD2\'}));
    folders = dir(BDfolder);
    folders(3) = [];folders(2) = [];folders(1) = [];
    
    for i = 1:length(folders)
        idir = folders(i);
        dirname = horzcat(idir(i).folder,'\',idir(i).name);
        d = dir(dirname);
        d(2) = []; d(1) = [];
        nf = size(d);

        for i = 1:nf 
            filename = horzcat(d(i).folder,'\',d(i).name);
            img = imread(filename);
            imshow(img);
        end
    end
   
end

