function [ BestBox, BestKernel ] = findBestPredictorParams(x,y)
    
    boxPars = [0.5, 1, 1.5, 2];
    kernelPars = ["linear","polynomial","rbf"];
    for i = 1:length(boxPars)
        for j = 1:length(kernelPars)
            bpar = boxPars(i);
            kpar = kernelPars(j);
            Error(i,j) = kfoldCrossValidation(x,y,bpar,kpar);
        end
    end
    
    minMatrix = min(Error(:));
    [box,kernel] = find(Error==minMatrix);
    BestBox = boxPars(box(1));
    BestKernel = kernelPars(kernel(1));
    
end