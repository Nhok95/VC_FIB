clear all;
clc;

% LOAD FLAGS: IF (FLAG == 1), LOAD FILES FROM DISKS
LOADTRAINDATA = 1; 
LOADPREDICTORPARAMS = 1; 
LOADPREDICTOR = 1;

LOADMIRAMDATA = 1;
LOADMIRAMPREDICTORPARAMS = 1;
LOADMIRAMPREDICTOR = 1;

fprintf('RUNNING WITH CONSTANTS: \n');
CONSTANTS

fprintf('scanning train images... \n');
scan = myscanfiles();

if (LOADTRAINDATA == 1)
    fprintf('loading saved train data... \n');
    load('VARIABLES\trainParameters.mat', 'Parameters');
    load('VARIABLES\trainLabels.mat', 'Labels');
    
else
    fprintf('generating train data... \n');
    [Parameters, Labels] = createData(scan);
    save('VARIABLES\trainParameters.mat', 'Parameters');
    save('VARIABLES\trainLabels.mat', 'Labels');
end

if (LOADPREDICTORPARAMS == 1)
    fprintf('loading saved best predictor params... \n');
    load('VARIABLES\BestBox.mat', 'BestBox');
    load('VARIABLES\BestKernel.mat', 'BestKernel');
else
    fprintf('computing best predictor params... \n');
    [BestBox, BestKernel] = findBestPredictorParams(Parameters,Labels);
    save('VARIABLES\BestBox.mat', 'BestBox');
    save('VARIABLES\BestKernel.mat', 'BestKernel');
end

if (LOADPREDICTOR == 1)
    
    fprintf('loading saved predictor and split data... \n');
    load('VARIABLES\predictor.mat','predictor');
    load('VARIABLES\splitData.mat','splitDataS');
    X_learning = splitDataS{1};
    X_test = splitDataS{2};
    Y_learning = splitDataS{3};
    Y_test = splitDataS{4};
else
    
    fprintf('splitting data into Train/Test... \n');
    [X_learning, X_test, Y_learning, Y_test] = splitData(Parameters, Labels);
    splitDataS{1} = X_learning;
    splitDataS{2} = X_test;
    splitDataS{3} = Y_learning;
    splitDataS{4} = Y_test;
    save('VARIABLES\splitData.mat', 'splitDataS');
        
    fprintf('fitting SVM model with Train data... \n');
    predictor = fitcsvm(X_learning, Y_learning, 'BoxConstraint', BestBox, 'KernelFunction', BestKernel,...
        'ClassNames',[CONSTANTS.FALSE_VALUE, CONSTANTS.TRUE_VALUE]);
    save('VARIABLES\predictor.mat', 'predictor');
    
end
%Learning data
fprintf('Predicting labels for Learning data... \n');
results = int8(predict(predictor,X_learning));

fprintf('Confusion matrix obtained: \n');
cMatrix = confusionmat(Y_learning,results);
errorLearning = cMatrix(1,2)+cMatrix(2,1);
eL = (errorLearning/length(Y_learning))*100;
%confusionchart(Y_learning,results); 

%Test data
fprintf('Predicting labels for Test data... \n');
results2 = int8(predict(predictor,X_test));
    
fprintf('Confusion matrix obtained: \n');
cMatrix2 = confusionmat(Y_test,results2);
errorTesting = cMatrix2(1,2)+cMatrix2(2,1);
eT = (errorTesting/length(Y_test))*100;
%confusionchart(Y_test,results2);  

%Special test
fprintf('predicting test data... \n');
testResults = loadTestData(predictor);



if (LOADMIRAMDATA == 1)
    fprintf('loading saved miram data... \n');
    load('VARIABLES\miramParameters.mat','miramParameters');
    load('VARIABLES\miramLabels.mat', 'miramLabels');
    
else
    fprintf('scanning Miram file... \n');
    miramLabels = readMiram();
    
    fprintf('generating miram data... \n');
    miramParameters = createData2(scan);
    save('VARIABLES\miramParameters.mat','miramParameters');
    save('VARIABLES\miramLabels.mat', 'miramLabels');
end

if (LOADMIRAMPREDICTORPARAMS == 1)
    fprintf('loading saved best miram predictor params... \n');
    load('VARIABLES\miramBestBox.mat', 'miramBestBox');
    load('VARIABLES\miramBestKernel.mat', 'miramBestKernel');
else
    fprintf('computing best miram predictor params... \n');
    [miramBestBox, miramBestKernel] = findBestPredictorParams(miramParameters,miramLabels);
    save('VARIABLES\miramBestBox.mat', 'miramBestBox');
    save('VARIABLES\miramBestKernel.mat', 'miramBestKernel');
end

if (LOADMIRAMPREDICTOR == 1)
    
    fprintf('loading saved miram predictor and miram split data... \n');
    load('VARIABLES\mirampredictor.mat','mirampredictor');
    load('VARIABLES\miramsplitData.mat','miramsplitData');
    X_learningM = miramsplitData{1};
    X_testM = miramsplitData{2};
    Y_learningM = miramsplitData{3};
    Y_testM = miramsplitData{4};
else   
    fprintf('splitting data into Train/Test... \n');
    miramLabels = miramLabels';
    [X_learningM, X_testM, Y_learningM, Y_testM] = splitData(miramParameters, miramLabels);
    miramsplitData{1} = X_learningM;
    miramsplitData{2} = X_testM;
    miramsplitData{3} = Y_learningM;
    miramsplitData{4} = Y_testM;
    save('VARIABLES\miramsplitData.mat', 'miramsplitData');
        
    fprintf('fitting SVM model with Train data... \n');
    mirampredictor = fitcsvm(X_learningM, Y_learningM, 'BoxConstraint', miramBestBox, 'KernelFunction', miramBestKernel,...
        'ClassNames',[CONSTANTS.FALSE_VALUE, CONSTANTS.TRUE_VALUE]);
    save('VARIABLES\mirampredictor.mat', 'mirampredictor');
    
end

%Learning data
fprintf('Predicting labels for miram Learning data... \n');
miramresults = int8(predict(mirampredictor,X_learningM));

fprintf('Confusion matrix obtained: \n');
cMatrixM = confusionmat(Y_learningM,miramresults);
errorLearningM = cMatrixM(1,2)+cMatrixM(2,1);
eLM = (errorLearningM/length(Y_learningM))*100;
%confusionchart(Y_learningM,miramresults);

%Test data
fprintf('Predicting labels for miram Test data... \n');
miramresults2 = int8(predict(mirampredictor,X_testM));
    
fprintf('Confusion matrix obtained: \n');
cMatrixM2 = confusionmat(Y_testM,miramresults2);
errorTestingM = cMatrixM2(1,2)+cMatrixM2(2,1);
eTM = (errorTestingM/length(Y_testM))*100;
%confusionchart(Y_testM,miramresults2);  

%fprintf('scanning columbia gaze DB... \n');
%c = readColumbiaDir(predictor);