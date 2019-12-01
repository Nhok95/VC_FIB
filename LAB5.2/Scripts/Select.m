function [Selected,rect] = Select(I)
    imshow(I);
    rect = getrect();
    %rect = [380.0 28.0 531.0 463.0];   %Valor obtingut amb imshow(Indg)+getrect()
    Selected = imcrop(I,rect);          %Retallem el rectangle obtingut
end

