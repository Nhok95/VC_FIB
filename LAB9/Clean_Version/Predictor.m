function [class] = Predictor(Mostra, Caract)
    EuclideanDistL = zeros(1,30);
    for i = 1:30
        template = struct2array(Caract(:,i));
        Sum = 0;
        nf = numel(fieldnames(Caract));
        for j = 2:nf
            Sum = Sum + ((template{j}- Mostra{j})^2);
        end
        EuclideanDistL(i) = sqrt(Sum);
    end
    [~, class] = min(EuclideanDistL);              
end

