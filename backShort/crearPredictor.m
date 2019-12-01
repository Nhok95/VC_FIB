function [ predictor ] = crearPredictor( Data )
%x són les dades per predir
%y és si/no (1,-1)

    y(:,1) = [Data(:).eye];
    x(:,1) = double([Data(:).x]);
    x(:,2) = double([Data(:).y]);
    x(:,3) = double([Data(:).width]);
    x(:,4) = double([Data(:).height]);
    %Train the SVM Classifier
    predictor = fitcsvm(x,y,'KernelFunction','rbf','BoxConstraint',Inf,'ClassNames',[-1,1]);

end

