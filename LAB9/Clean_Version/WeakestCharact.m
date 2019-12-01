function [Weakest] = WeakestCharact(Caract,Caract2)
    fields = fieldnames(Caract);
    ErrorsList = zeros(1,8);
    for i = 2:9                  %Bucle per extreue la caracteritica i-1
        Aux = rmfield(Caract,fields{i});
        Aux2 = rmfield(Caract2,fields{i});

        M = ConfusionMatrix(Aux,Aux2);   %Conf matrix sense la caract i-1
        Errors = GetError(M);
        %Encerts = GetSuccess(M);
        ErrorsList(i-1) = Errors;
    end
    %[~,indexS] = max(ErrorsList);
    [~,indexW] = min(ErrorsList);

    %Strongest = fields{indexS+1};
    Weakest = fields{indexW+1};
end



