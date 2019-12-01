clear all;
clc;

LOAD1 = 0; %LOAD = 1 -> CARGAMOS LOS DATOS PREVIAMENTE GUARDADOS
LOAD2 = 0;

fprintf('scanning train images... \n');
scan = myscanfiles();

if (LOAD1 == 1)
    fprintf('loading train data... \n');
    load('VARIABLES\trainParameters.mat', 'Parameters');
    load('VARIABLES\trainLabels.mat', 'Labels');
    
else
    fprintf('generating train data... \n');
    [Parameters, Labels] = createData(scan);
    save('VARIABLES\trainParameters.mat', 'Parameters');
    save('VARIABLES\trainLabels.mat', 'Labels');
end

if (LOAD2 == 1)
    fprintf('loading SVM predictor... \n');
    load('VARIABLES\SVMpredictor.mat', 'predictor');
    load('VARIABLES\SVMcMat.mat', 'cMat');
    confusionchart(cMat);
    Error = cMat(1,2)+cMat(2,1);
else
    fprintf('creating SVM predictor... \n');
    [predictor, cMat] = createPredictor(Parameters,Labels);
    cMat;
    Error = cMat(1,2)+cMat(2,1);
    save('VARIABLES\SVMpredictor.mat', 'predictor');
    save('VARIABLES\SVMcMat.mat', 'cMat');
end

fprintf('predicting test data... \n');
testResults = loadTestData(predictor);

