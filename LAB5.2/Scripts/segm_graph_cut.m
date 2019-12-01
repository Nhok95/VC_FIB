clc;
clear all;
% segmentacio per nivell de gris utilitzant Graph Cut
I = imread('coins.jpg');
Indg = rgb2gray(I);
imshow(Indg);
Ir = imresize(Indg,[100 120]);
%h = imhist(Ir);
%plot(h); pause

[F C] = size(Ir);
WM = zeros(F*C,F*C); % creacio de la matriu de pesos (lligams entre pixels)

If = double(255-Ir); % lligam amb el foreground (gris clar)
Ib = double(Ir-215); % lligam amb el background (blanc)

% definim (aribtrariament) el node (1,1) de la matriu WM com a foreground
% i el node WM(F*C,F*C) com a background

% lligam entre el foreground (1,1) a tots els pixels 
WM(1,1:F*C) = If(:)';
% la matriu ha de ser simetrica
WM(1:F*C,1) = If(:);

% lligam entre el background (1,1) a tots els pixels
WM(F*C,1:F*C) = Ib(:);  
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
     v = double(30-abs(Ir(f,c) - Ir(f+1,c))); % quant menys diferencia mes lligam
     WM(f+(c-1)*F,f+1+c*F) = v;
     WM(f+1+c*F,f+(c-1)*F) = v; % la matriu ha de ser simetrica
     %diferencia de ndg amb el vei del costat
     v = double(30-abs(Ir(f,c) - Ir(f,c+1)));
     WM(f+(c-1)*F,f+c*F) = v;
     WM(f+c*F,f+(c-1)*F) = v;
     %diferencia de ndg amb el vei en diagonal
     v = double(30-abs(Ir(f,c) - Ir(f+1,c+1)));
     WM(f+(c-1)*F,f+1+c*F) = v;
     WM(f+1+c*F, f+(c-1)*F) = v;
 end
end

G = graph(WM);
[mf,~,foreground,background] = maxflow(G,1,F*C);

Is = Ir;
Is(background) = 255;
figure;imshow(Is,[]);
