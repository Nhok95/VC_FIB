function [Caract] = ObtenirCaract(I)
    Labels = {'0','1','2','3','4','5','6','7','8','9','B','C','D','F','G','H','J','K','L','M','N','P','R','S','T','V','W','X','Y','Z'};
    %Volem Construir un struct per guardar les 8 caracteristiques (Fems servir struct per comoditat)
    for i=1:30
        Caract(i).label = Labels(i);
    end

    BW = rgb2gray(I) < 35;   %Binaritzem
    CC = bwconncomp(BW);
    S = regionprops(CC,'Perimeter','Centroid', 'BoundingBox','EulerNumber','EquivDiameter','ConvexArea','MajorAxisLength','MinorAxisLength','FilledArea');
    np = cellfun(@numel,CC.PixelIdxList);
    [value, ~] = max(np);
    np = bsxfun(@rdivide,np,value); %Normalitzem el numero de pixels
    PerimeterList = cat(1,S.Perimeter);
    [value, ~] = max(PerimeterList);
    PerimeterList = PerimeterList.';
    PerimeterList = bsxfun(@rdivide,PerimeterList,value);  %Normalitzem el numero de pixels del perimetre
    BBList = cat(1,S.BoundingBox);
    
    %Caract. 1 -> Compactness 
    CompList = zeros(1,30);
    for i=1:30
        CompList(i) = PerimeterList(i)^2/np(i);
    end
    [value, ~] = max(CompList);
    CompList = bsxfun(@rdivide,CompList,value);
    T = num2cell(CompList);
    [Caract(1:length(T)).Compactness] = T{:};
    
    %Caract. 2 -> Euler Number (Forats)
    EuList = cat(1,S.EulerNumber);
    EuList = EuList.';
    for i = 1:30
        EuList(i) = 1-EuList(i); 
    end
    [value, ~] = max(EuList);
    EuList = bsxfun(@rdivide,EuList,value);
    T = num2cell(EuList);
    [Caract(1:length(T)).Forats] = T{:};
    
    
    %Caract. 3 -> ConvexArea
    ConvexList = cat(1,S.ConvexArea);
    ConvexList = ConvexList.';
    [value, ~] = max(ConvexList);
    ConvexList = bsxfun(@rdivide,ConvexList,value);
    T = num2cell(ConvexList);
    [Caract(1:length(T)).ConvexArea] = T{:};
    
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
    
    %Caract. 8 -> EquivDiameter
    EDiamList = cat(1,S.EquivDiameter);
    EDiamList = EDiamList.';
    [value, ~] = max(EDiamList);
    EDiamList = bsxfun(@rdivide,EDiamList,value);
    T = num2cell(EDiamList);
    [Caract(1:length(T)).EquivDiameter] = T{:};
    
    %{
    %Codi per comprobar que les lletres estan en ordre (El representem amb colors)
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
end

