%Reconeixement

%1. Calcular 8 característiques de forma o de área del joc de caracters
%(invariants) 
I = imread('Joc_de_caracters.jpg');
Caract = ObtenirCaract(I);


%3. Testing {Jocs de caracters deformats}
% Matriu de confució-> Error

%M = ConfusionMatrix()
M = zeros(30,30); %31 representa el error de no saber clasificar.
ID = imread('Joc_de_caracters_deformats II.png');
CaractEx = ObtenirCaract(ID);

for k = 1:30
    Mostra = CaractEx(:,k);
    %%%class = Predictor(Mostra, Caract);
    EuclideanDistL = zeros(1,30);
    for i = 1:30
        template = Caract(:,i); 
        Sum = 0;
        for j = 1:6
            %sdList = [Caract(j,:) template(j)];
            %var = std(sdList)^2;
            Sum = Sum + ((template(j)- Mostra(j))^2)/1;
        end
        EuclideanDistL(i) = sqrt(Sum);
    end
    [value, class] = min(EuclideanDistL);
    %if (value > 0.5) 
    %    M(k,31) = M(k,31) + 1;
    %else
    M(k,class) = 5555;
    %end
    
end

%Error = GetError(M);
SError = 0;
for i = 1:29
    for j = i+1:30
        SError = SError + M(i,j)/5555+M(j,i)/5555;
    end
end

SEncerts = 0;
for i = 1:30
    SEncerts = SEncerts + M(i,i)/5555;
end


%Struct -> s.a = {'A','B','C'}