function [Dirs] = readColumbiaDir(predictor)
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
            I = rgb2gray(imread(filename));
            % all images will have a similar size
            I = imresize(I,CONSTANTS.SCALE);
            hasEyes = findEyes(I, predictor);
        end
    end
   
end

