function [ predictorF, cMatrix ] = createPredictor(x,y)
    
    boxPars = [0.5, 1, 1.5, 2, 2.5];
    kernelPars = ["linear","polynomial","rbf"];
    for i = 1:length(boxPars)
        for j = 1:length(kernelPars)
            bpar = boxPars(i);
            kpar = kernelPars(j);
            Error(i,j) = kfoldCrossValidation(x,y,bpar,kpar);
        end
    end
    
    minMatrix = min(Error(:));
    [row,col] = find(Error==minMatrix);
    BetterBox = boxPars(row(1));
    BetterKernel = kernelPars(col(1));
    
    %Train the SVM Classifier
    predictorF = fitcsvm(x,y,'BoxConstraint', BetterBox,'KernelFunction',BetterKernel,'ClassNames',[CONSTANTS.FALSE_VALUE,CONSTANTS.TRUE_VALUE]);
    %predictor = fitcsvm(x,y,'Standardize',true,'KernelFunction','rbf','ClassNames',[-1,1]);
    
    ypF = int8(predict(predictorF,x));
    cMatrix = confusionmat(y,ypF);
    confusionchart(y,ypF);

end