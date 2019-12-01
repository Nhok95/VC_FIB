function [M] = ConfusionMatrix(Caract,Caract2)
    M = zeros(30,30);
    for k = 1:30
        Mostra = struct2array(Caract2(:,k)); 
        class = Predictor(Mostra, Caract);  %Volem saber quin simbol és fent servir els templates
        M(k,class) = 1;   %Asignem el simbol a la clase corresponent
    end
end

