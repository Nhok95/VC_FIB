function [RC,RF] = myBoundaryF(BW)
    CC = bwconncomp(BW);
    idxlists = CC.PixelIdxList;
    pixels = idxlists{1};
    [F,C] = ind2sub(size(BW), pixels);
    % exterior boundary
    k = boundary([F,C],0.15); % loose factor = 0.15 
    % reduce polygonal
    [RF,RC] = reducem(F(k),C(k),5); % tolerance = 5 degrees
    %plot boundary
    imshow(128*uint8(BW));hold
    plot(RC,RF,'LineWidth',8);
end

