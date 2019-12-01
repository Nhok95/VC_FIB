function [Is] = Fragmentacio(Indg, Histo_background,Histo_foreground)
    [ndgF,ndgC] = size(Indg); 
    Ir = imresize(Indg,[ndgF/6 ndgC/6]);
    
    [F,C] = size(Ir);
    WM = zeros(F*C,F*C); % creacio de la matriu de pesos (lligams entre pixels)
    
    Av_fore = Average_ndg(Histo_foreground);
    Av_back = Average_ndg(Histo_background);
    
    If = abs(double(Av_fore-Ir)); % lligam amb el foreground
    Ib = abs(double(Ir-Av_back)); % lligam amb el background

    % definim (aribtrariament) el node (1,1) de la matriu WM com a foreground
    % i el node WM(F*C,F*C) com a background

    % lligam entre el foreground (1,1) a tots els pixels 
    WM(1,1:F*C) = If(:)';
    % la matriu ha de ser simetrica
    WM(1:F*C,1) = If(:);

    % lligam entre el background (1,1) a tots els pixels
    WM(F*C,1:F*C) = Ib(:)';  
    WM(1:F*C,F*C) = Ib(:);

    % no hi ha d'haveri cap lligam entre el foreground i el background
    WM(1,F*C) = 0; 
    WM(F*C,1) = 0;
    WM(F*C,F*C) = 0;
    WM(1,1) = 0;

    % lligam entre un pixel i els seus dos veins
    for c=2:C-1
     for f=2:F-1
         %diferencia de ndg amb el vei de sota
         v = abs(Ir(f,c) - Ir(f+1,c)); % quant menys diferencia mes lligam
         v = max(0,min(1, 1 - v/32));
         WM(f+(c-1)*F,f+1+(c-1)*F) = v;
         WM(f+1+(c-1)*F,f+(c-1)*F) = v; % la matriu ha de ser simetrica
         %diferencia de ndg amb el vei del costat
         v = abs(Ir(f,c) - Ir(f,c+1)); % quant menys diferencia mes lligam
         v = max(0,min(1, 1 - v/32));
         WM(f+(c-1)*F,f+c*F) = v;
         WM(f+c*F,f+(c-1)*F) = v;
         %diferencia de ndg amb la diagonal
         v = abs(Ir(f,c) - Ir(f+1,c+1)); % quant menys diferencia mes lligam
         v = max(0,min(1, 1 - v/32));
         WM(f+(c-1)*F,f+1+c*F) = v;
         WM(f+1+c*F,f+(c-1)*F) = v;
     end
    end

    G = graph(WM);
    [mf,~,foreground,background] = maxflow(G,1,F*C);

    Is = Ir;
    if Av_fore < 128
        Is(background) = 255;
        %Is(foreground) = 0;
    elseif Av_fore >= 128
        Is(background) = 0;
        %Is(foreground) = 255;
    end
end

