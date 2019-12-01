function [Error] = kfoldCrossValidation(x,y,par,par2)
    fprintf('Cross Validation for par =[ %d, %s]... \n', par,par2);
    
    %cvpartition
    ind = crossvalind('Kfold',y,CONSTANTS.KFOLD);
    for i = 1:CONSTANTS.KFOLD
        validation = (ind == i); 
        train = ~validation;
        xtrain = x(train);
        ytrain = y(train);
        
        xtest = x(validation);
        ytest = y(validation);
        
        pred = fitcsvm(xtrain,ytrain, 'BoxConstraint', par, 'KernelFunction',par2,'ClassNames',[CONSTANTS.FALSE_VALUE,CONSTANTS.TRUE_VALUE]);
        
        ypred = int8(predict(pred,xtest));
        cMatrix = confusionmat(ytest,ypred);
        
        Error_vect(i) = cMatrix(1,2)+cMatrix(2,1);
    end
    
    Error = sum(Error_vect)/CONSTANTS.KFOLD;
    Error_per = (Error/length(y))*100;
end

