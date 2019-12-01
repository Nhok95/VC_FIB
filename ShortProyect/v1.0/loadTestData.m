function [ predictedLabels, testLabels ] = predictTestData(predictor)
  
    imgDir = char(strcat(pwd, {'\REAL\*.png'}));
    %imgDir = char(strcat(pwd, {'\REAL\*.jpg'}));
    infoDir = char(strcat(pwd, {'\REAL\*.txt'}));
    imgFiles = dir(imgDir);
    infoFiles = dir(infoDir);
    [numberOfImages, ~] = size(imgFiles);
    [numberOfInfoFiles, ~] = size(infoFiles);
    
    
    predictedLabels = zeros(1,numberOfImages);
    testLabels = zeros(1,numberOfInfoFiles);
    
    
    if(numberOfInfoFiles ~= numberOfImages)
        fprintf('ERROR LOADING TEST FILES');
    else
        
        for i = 1:numberOfImages
            imgFilename = horzcat(imgFiles(i).folder,'\',imgFiles(i).name);
            infoFilename = horzcat(infoFiles(i).folder,'\',infoFiles(i).name);
            
            info = fopen(infoFilename);
            c = textscan(info, '%d', 1, 'delimiter', '\n');
            testLabels(i) = c{1};
            
            I = rgb2gray(imread(imgFilename));
            % all images will have a similar size
            I = imresize(I,CONSTANTS.SCALE);
            hasEyes = findEyes(I, predictor);
            predictedLabels(i) = hasEyes;
            %{
            imageSize = size(I);
            resizeRatio = CONSTANTS.SCALEX / imageSize(1);
            newSize = uint16(imageSize * resizeRatio);
            if(newSize(2) < CONSTANTS.RECT_SIZE(2))
                 fprintf('IMAGE %d NOT VALID', i);
            else
                I = imresize(I,newSize);
                hasEyes = findEyes(I, predictor);
                predictedLabels(i) = hasEyes;
            end
            %}
        end
    end
    
    
end