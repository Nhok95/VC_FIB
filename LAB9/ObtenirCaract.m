function [Caract] = ObtenirCaract(I)
    Labels = {'0','1','2','3','4','5','6','7','8','9','B','C','D','F','G','H','J','K','L','M','N','P','R','S','T','V','W','X','Y','Z'};
    for i=1:30
        Caract(i).label = Labels(i);
    end
    %
    %zeros(7,30); % Vector amb 8 (2 per ara) caracteristiques per simbol

    BW = rgb2gray(I) < 35;
    
    CC = bwconncomp(BW);
    S = regionprops(CC,'Perimeter','Centroid', 'BoundingBox','EulerNumber','MajorAxisLength','MinorAxisLength','FilledArea');
    %Caract. - -> Nº Pixels (Area)
    %Caract. - -> Nº Pixels (Perimetre)
    np = cellfun(@numel,CC.PixelIdxList);
    [value, ~] = max(np);
    np = bsxfun(@rdivide,np,value);
    %npNorm = [npNorm, -1];
    %Caract(1,:) = npNorm;
    PerimeterList = cat(1,S.Perimeter);
    [value, ~] = max(PerimeterList);
    PerimeterList = PerimeterList.';
    PerimeterList = bsxfun(@rdivide,PerimeterList,value);
    %PerimeterNorm = [PerimeterNorm, -1];
    %Caract(2,:) = PerimeterNorm;
    
    %Caract. 1 -> Compactness 
    CompList = zeros(1,30);
    for i=1:30
        CompList(i) = PerimeterList(i)^2/np(i);
    end
    [value, ~] = max(CompList);
    CompList = bsxfun(@rdivide,CompList,value);
    T = num2cell(CompList);
    [Caract(1:length(T)).Compactness] = T{:};
    
    %Caract. 2 -> Euler Number
    EuList = cat(1,S.EulerNumber);
    EuList = EuList.';
    for i = 1:30
        EuList(i) = 1-EuList(i); 
    end
    [value, ~] = max(EuList);
    EuList = bsxfun(@rdivide,EuList,value);
    T = num2cell(EuList);
    [Caract(1:length(T)).Forats] = T{:};
    
    %Caract. 3 -> Horizontal_vs_Vertical
    BBList = cat(1,S.BoundingBox);
    HList = zeros(1,30);
    VList = zeros(1,30);
    for i = 1:30
        HList(i) = findLargestHorizontalLine(BW,BBList(i,:));
        VList(i) = findLargestVerticalLine(BW,BBList(i,:));
    end
    [value, ~] = max(HList);
    HList = bsxfun(@rdivide,HList,value);
    [value, ~] = max(VList);
    VList = bsxfun(@rdivide,VList,value);
    T = zeros(1,30);
    for i = 1:30
        T(i) = abs(HList(i)-VList(i));
    end
    T = num2cell(T);
    [Caract(1:length(T)).HV] = T{:};
    
    %Caract. 4 -> MajorAxisLength
    MaList = cat(1,S.MajorAxisLength);
    MaList = MaList.';
    [value, ~] = max(MaList);
    MaList = bsxfun(@rdivide,MaList,value);
    T = num2cell(MaList);
    [Caract(1:length(T)).MajAxisL] = T{:};
    
    %Caract. 5 -> MinorAxisLength
    MinaList = cat(1,S.MinorAxisLength);
    MinaList = MinaList.';
    [value, ~] = max(MinaList);
    MinaList = bsxfun(@rdivide,MinaList,value);
    T = num2cell(MinaList);
    [Caract(1:length(T)).MinAxisL] = T{:};
    
    %Caract. 6 -> Simetria vertical 
    %(Quantitat de pixels a l'esquerra / Quantitat de pixels a la dreta)
    VertSimList = zeros(1,30);
    for i = 1:30
        VertSimList(i) = SimetriaVertical(BW, BBList(i,:));
    end
    [value, ~] = max(VertSimList);
    VertSimList = bsxfun(@rdivide,VertSimList,value);
    T = num2cell(VertSimList);
    [Caract(1:length(T)).SimVert] = T{:};
    
    
    %Caract. 7 -> Simetria horitzontal 
    %(Quantitat de pixels a dalt / Quantitat de pixels a sota)
    HoriSimList = zeros(1,30);
    for i = 1:30
        HoriSimList(i) = SimetriaHoritzontal(BW, BBList(i,:));
    end
    [value, ~] = max(HoriSimList);
    HoriSimList = bsxfun(@rdivide,HoriSimList,value);
    T = num2cell(HoriSimList);
    [Caract(1:length(T)).SimHor] = T{:};
    
    %Caract. 8 -> FilledArea
    FAreaList = cat(1,S.FilledArea);
    FAreaList = FAreaList.';
    [value, ~] = max(FAreaList);
    FAreaList = bsxfun(@rdivide,FAreaList,value);
    T = num2cell(FAreaList);
    [Caract(1:length(T)).FilledI] = T{:};
    
    %{ 
    %Caract. 2 -> Elongation
    %ElonList = zeros(1,30);
    %for i = 1:30
    %    ElonList(i) = BBList(i,4)/BBList(i,3);
    %end
    %[value, ~] = max(ElonList);
    %ElonNorm = bsxfun(@rdivide,ElonList,value);
    %Caract(2,:) = ElonNorm;
    
    %Caract. 3 -> LargestHorizontalLine
    BBList = cat(1,S.BoundingBox);
    HList = zeros(1,30);
    for i = 1:30
        HList(i) = findLargestHorizontalLine(BW,BBList(i,:));
    end
    [value, ~] = max(HList);
    HNorm = bsxfun(@rdivide,HList,value);
    T = num2cell(HNorm);
    [Caract(1:length(T)).Horizontal] = T{:};
    
    %Caract. 4 -> findLargestVerticalLine
    VList = zeros(1,30);
    for i = 1:30
        VList(i) = findLargestVerticalLine(BW,BBList(i,:));
    end
    [value, ~] = max(VList);
    VNorm = bsxfun(@rdivide,VList,value);
    T = num2cell(VNorm);
    [Caract(1:length(T)).Vertical] = T{:};
    
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
    
    %Caract. 3 -> Horizontal_vs_Vertical
    
    BBList = cat(1,S.BoundingBox);
    
    HList = zeros(1,30);
    VList = zeros(1,30);
    for i = 1:30
        HList(i) = findLargestHorizontalLine(BW,BBList(i,:));
        VList(i) = findLargestVerticalLine(BW,BBList(i,:));
    end
    %[value, ~] = max(HList);
    %HList = bsxfun(@rdivide,HList,value);
    %[value, ~] = max(VList);
    %VList = bsxfun(@rdivide,VList,value);
    T = zeros(1,30);
    for i = 1:30
        T(i) = (VList(i)-HList(i))^2;
    end
    [value, ~] = max(T);
    T = bsxfun(@rdivide,T,value);
    T = num2cell(T);
    %[Caract(1:length(T)).HV] = T{:};
    
    %}
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

