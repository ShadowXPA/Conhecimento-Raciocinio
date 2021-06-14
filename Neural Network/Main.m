function Main()
clear;
close all;

% a();
b();
end

function a()
% Carregar imagens
%     [imageInput, imageTarget] = GetImages('Pasta2/*.jpg', 'letter_bnw_%d', 1);
[imageInput, imageTarget] = GetImages('Pasta1/*.jpg', '%d');

% Criar rede neuronal
net = feedforwardnet([10]);

% Função de ativação
net.layers{2}.transferFcn = 'tansig';

% Função de treino
net.trainFcn = 'traingdx';

% Número de épocas
net.trainParam.epochs = 1000;

%
net.divideFcn = '';

% Treino
[net, tr] = train(net, imageInput, imageTarget);

% Simular
%     [imageInput, imageTarget] = GetImages('Pasta1/*.jpg', '%d');
y = sim(net, imageInput);

% accuracy = CalculateAccuracy(y, imageTarget);
% fprintf('Precisão total: %f\n', accuracy);
%
% accuracyTest = CalculateAccuracy(y(:, tr.testInd), imageTarget(:, tr.testInd));
% fprintf('Precisão teste: %f\n', accuracyTest);

plotconfusion(imageTarget, y);
end

function b()
% Carregar imagens
[imageInput, imageTarget] = GetImages('Pasta2/*.jpg', 'letter_bnw_%d', 1);

layers = [{[10]},...
    {[20]},...
    {[5 5]},...
    {[10 10]}];

transferFcns = [{'logsig'},...
    {'purelin'},...
    {'tansig'}];

%'trainbfg',...
trainFcns = [{'traingd'},...
    {'traingdx'},...
    {'trainlm'}];

divideFcns = [{'dividerand'},...
    {'divideblock'},...
    {'divideint'}];

divideParams = [{[0.7 0.15 0.15]},...
    {[0.8 0.1 0.1]},...
    {[0.6 0.2 0.2]}];

sizeOfLayers = size(layers, 2);
sizeOfTransfer = size(transferFcns, 2);
sizeOfTrain = size(trainFcns, 2);
sizeOfDivide = size(divideFcns, 2);
sizeOfParams = size(divideParams, 2);

for lay = 1 : sizeOfLayers
    for trans = 1 : sizeOfTransfer
        for trai = 1 : sizeOfTrain
            for divi = 1 : sizeOfDivide
                for param = 1 : sizeOfParams
                    fprintf(string(strjoin(["bestNetwork" layers{lay} transferFcns{trans} trainFcns{trai} divideFcns{divi} divideParams{param} ".mat"])));
                    
                    % Criar rede neuronal
                    net = feedforwardnet(layers{lay});
                    
                    % Função de ativação
                    act = size(layers{lay}, 2) + 1;
                    net.layers{act}.transferFcn = transferFcns{trans};
                    
                    % Função de treino
                    net.trainFcn = trainFcns{trai};
                    
                    % Número de épocas
                    net.trainParam.epochs = 500;
                    
                    %
                    net.divideFcn = divideFcns{divi};
                    net.divideParam.trainRatio = divideParams{param}(1);
                    net.divideParam.valRatio = divideParams{param}(2);
                    net.divideParam.testRatio = divideParams{param}(3);
                    
                    % Treino
                    [net, tr] = train(net, imageInput, imageTarget);
                    
                    % Simular
                    %     [imageInput, imageTarget] = GetImages('Pasta1/*.jpg', '%d');
                    y = sim(net, imageInput);
                    
                    accuracy = CalculateAccuracy(y, imageTarget);
                    fprintf('\nPrecisão total: %f\n', accuracy);
                    
                    accuracyTest = CalculateAccuracyTest(y, imageTarget, tr);
                    fprintf('Precisão teste: %f\n', accuracyTest);
                    
                    fileName = string(strjoin(["RedesGravadas/bestNetworkB" layers{lay} transferFcns{trans} trainFcns{trai} divideFcns{divi} divideParams{param} ".mat"]));
                    SaveBestNetwork(fileName, net, accuracy, accuracyTest);
                    SaveBestNetwork("RedesGravadas/bestNetworkB.mat", net, accuracy, accuracyTest);
                end
            end
        end
    end
end
end
