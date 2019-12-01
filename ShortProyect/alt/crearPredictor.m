function [ predictor ] = crearPredictor( Data )
%x són les dades per predir
%y és si/no (1,-1)

    y(:,1) = int8([Data(:).eye]);
    %x(:,1) = double([Data(:).featVector]);
    [~,s] = size(Data);
    for i = 1:s
        x(i,:) = double([Data(i).featVector]);
    end    
    
    %Train the SVM Classifier
    predictor = fitcsvm(x,y,'KernelFunction','rbf','ClassNames',[-1,1]);
    
    yp = int8(predict(predictor,x));
    errors = abs(y-yp);
    sum(errors)

end

%'BoxConstraint',Inf