function [X_learning, X_test, Y_learning, Y_test] = splitData(X,Y)
    
    rand_num = randperm(size(X,1));
    X_learning = X(rand_num(1:round(CONSTANTS.SPLIT_RATIO*length(rand_num))),:);
    Y_learning = Y(rand_num(1:round(CONSTANTS.SPLIT_RATIO*length(rand_num))),:);

    X_test = X(rand_num(round(CONSTANTS.SPLIT_RATIO*length(rand_num))+1:end),:);
    Y_test = Y(rand_num(round(CONSTANTS.SPLIT_RATIO*length(rand_num))+1:end),:);
    

end