function [Caract] = ObtenirCaract(I)
    Caract.labels = {'0','1','2','3','4','5','6','7','8','9','B','C','D','F','G','H','J','K','L','M','N','P','R','S','T','V','W','X','Y','Z'};
    %zeros(7,30); % Vector amb 8 (2 per ara) caracteristiques per simbol

    BW = rgb2gray(I) < 35;
    [f,c] = size(BW);
    
    %C.label = {'0','1','2','3','4','5','6','7','8','9','B','C','D','F','G','H','J','K','L','M','N','P','R','S','T','V','W','X','Y','Z'};
    %Caract.labels = C.labels;
    
    
    CC = bwconncomp(BW);
    S = regionprops(CC,'Perimeter','Centroid', 'BoundingBox','EulerNumber','Extent','Eccentricity','MajorAxisLength','MinorAxisLength');
    
    %Caract. - -> Nº Pixels (Area)
    %Caract. - -> Nº Pixels (Perimetre)
    np = cellfun(@numel,CC.PixelIdxList);
    [value, ~] = max(np);
    npNorm = bsxfun(@rdivide,np,value);
    %npNorm = [npNorm, -1];
    %Caract(1,:) = npNorm;
    
    
    PerimeterList = cat(1,S.Perimeter);
    [value, ~] = max(PerimeterList);
    PerimeterList = PerimeterList.';
    PerimeterNorm = bsxfun(@rdivide,PerimeterList,value);
    %PerimeterNorm = [PerimeterNorm, -1];
    %Caract(2,:) = PerimeterNorm;
    
    %Caract. 1 -> Compactness 
    CompList = zeros(1,30);
    for i=1:30
        CompList(i) = PerimeterNorm(i)^2/npNorm(i);
    end
    [value, ~] = max(CompList);
    CompNorm = bsxfun(@rdivide,CompList,value);
    Caract(2,:) = CompNorm;
    
    %Caract. 2 -> Euler Number
    EuList = cat(1,S.EulerNumber);
    EuList = EuList.';
    for i = 1:30
        EuList(i) = 1-EuList(i); 
    end
    [value, ~] = max(EuList);
    EuNorm = bsxfun(@rdivide,EuList,value);
    Caract(3,:) = EuNorm;
    
    %Caract. 3 -> LargestHorizontalLine
    BBList = cat(1,S.BoundingBox);
    HList = zeros(1,30);
    for i = 1:30
        HList(i) = findLargestHorizontalLine(BW,BBList(i,:));
    end
    [value, ~] = max(HList);
    HNorm = bsxfun(@rdivide,HList,value);
    Caract(4,:) = HNorm;
    
    %Caract. 4 -> findLargestVerticalLine
    VList = zeros(1,30);
    for i = 1:30
        VList(i) = findLargestVerticalLine(BW,BBList(i,:));
    end
    [value, ~] = max(VList);
    VNorm = bsxfun(@rdivide,VList,value);
    Caract(5,:) = VNorm;
    
    %Caract. 5 -> MajorAxisLength
    MaList = cat(1,S.MajorAxisLength);
    MaList = MaList.';
    [value, ~] = max(MaList);
    MaNorm = bsxfun(@rdivide,MaList,value);
    Caract(6,:) = MaNorm;
    
    %Caract. 6 -> MinoAxisLength
    MinaList = cat(1,S.MinorAxisLength);
    MinaList = MinaList.';
    [value, ~] = max(MinaList);
    MinaNorm = bsxfun(@rdivide,MinaList,value);
    Caract(7,:) = MinaNorm;
    
    
      
    %Caract. 2 -> Elongation
    %ElonList = zeros(1,30);
    %for i = 1:30
    %    ElonList(i) = BBList(i,4)/BBList(i,3);
    %end
    %[value, ~] = max(ElonList);
    %ElonNorm = bsxfun(@rdivide,ElonList,value);
    %Caract(2,:) = ElonNorm;
    
    %Caract. 4 -> Extent
    %ExList = cat(1,S.Extent);
    %ExList = ExList.';
    %[value, ~] = max(ExList);
    %ExNorm = bsxfun(@rdivide,ExList,value);
    %Caract(3,:) = ExNorm;
    
    
    
    
    %Caract. 7 -> Eccentricity
    %EccList = cat(1,S.Eccentricity);
    %EccList = EccList.';
    %[value, ~] = max(EccList);
    %EccNorm = bsxfun(@rdivide,EccList,value);
    %Caract(7,:) = EccNorm;
    
    %Caract. 8 -> Solidity
    %SolidityList = cat(1,S.Solidity);
    %SolidityList = SolidityList.';
    %[value, ~] = max(SolidityList);
    %SolNorm = bsxfun(@rdivide,SolidityList,value);
    %Caract(6,:) = SolNorm;
    
    
    %{
    RGB = I;
    for i = 1:CC.NumObjects
    %RGB = insertShape(RGB,'Rectangle',BBList(1,:), 'LineWidth', 4, 'Color', 'red');
        if (i < 10)
            RGB = insertShape(RGB,'Rectangle', BBList(i,:), 'LineWidth', 4, 'Color', 'blue');
        elseif (i < 20)
            RGB = insertShape(RGB,'Rectangle', BBList(i,:), 'LineWidth', 4, 'Color', 'yellow');
        else
            RGB = insertShape(RGB,'Rectangle', BBList(i,:), 'LineWidth', 4, 'Color', 'red');
        end
            
    end
    figure;imshow(RGB);
    
    RGB2 = I;
    color = 0;
    for i = 1:CC.NumObjects
        if (i < 10)
            RGB2(CC.PixelIdxList{i}) = color;
        elseif (i < 20)
            RGB2(CC.PixelIdxList{i}) = color;
        else
            RGB2(CC.PixelIdxList{i}) = color;
        end
        color = color+8.5;
    end
    figure; imshow(RGB2);
    %}
    
    %Caract. X -> Label
    %Caract(3,:) = ['0','1','2','3','4','5','6','7','8','9','B','C','D','F','G','H','J','K','L','M','N','P','Q','R','S','T','V','X','Y','Z','cap'];
    %Labels = ['0','1','2','3','4','5','6','7','8','9','B','C','D','F','G','H','J','K','L','M','N','P','R','S','T','V','W','X','Y','Z','-'];
    %Caract(3,:) = Labels;
    
    
    
    %
    %
end

