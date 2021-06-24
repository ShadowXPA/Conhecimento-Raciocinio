function Main()
clear;
close all;

% a();
% b();
c();
% d();
% alineaE();
end

function a()
% Carregar imagens
%     [imageInput, imageTarget] = GetImages('Pasta2/*.jpg', 'letter_bnw_%d', 1);
[imageInput, imageTarget] = GetImages('Pasta1/*.jpg', '%d');

% Criar rede neuronal
net = feedforwardnet([10]);

% Função de ativação
net.layers{2}.transferFcn = 'purelin';

% Função de treino
net.trainFcn = 'trainlm';

% Número de épocas
net.trainParam.epochs = 1000;

%
net.divideFcn = '';
% net.divideParam.trainRatio = 0.8;
% net.divideParam.valRatio = 0.1;
% net.divideParam.testRatio = 0.1;

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
trainFcns = [{'traingdx'},...
    {'trainlm'}];

divideFcns = [{'dividerand'},...
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

function c()
% Carregar imagens
[imageInput1, imageTarget1] = GetImages('Pasta1/*.jpg', '%d', 0);
[imageInput2, imageTarget2] = GetImages('Pasta2/*.jpg', 'letter_bnw_%d', 1);
[imageInput3, imageTarget3] = GetImages('Pasta3/*.jpg', 'letter_bnw_test_%d', 0);

load("RedesGravadas/bestNetworkB.mat", 'net', 'accuracy', 'accuracyTest');
% load("RedesGravadas/bestNetworkB 10 tansig traingdx divideint 0.8 0.1 0.1 .mat", 'net', 'accuracy', 'accuracyTest');
% load("RedesGravadas/bestNetworkB 10 tansig traingdx dividerand 0.8 0.1 0.1 .mat", 'net', 'accuracy', 'accuracyTest');
fprintf('Carregada a rede neuronal com %f de precisão total e %f de precisão de teste.\n', accuracy, accuracyTest);

% Sem treinar a rede verifique se a classificação dada pela RN é correta.
% Apresente os resultados obtidos.

% Simular
y = sim(net, imageInput3);

accuracy = CalculateAccuracy(y, imageTarget3);
fprintf('\nPrecisão total: %f\n', accuracy);

% -------------------------------------------------------------------------

% Agora volte a treinar a rede só com os exemplos da Pasta_3.
% Teste a rede separadamente para as imagens da Pasta_1, Pasta_2 e Pasta_3.
% Compare e registe os resultados obtidos em cada caso.

fprintf('\nTreinar a rede com imagens da Pasta_3\n');

[netTreinada, ~] = train(net, imageInput3, imageTarget3);

% Simular Pasta_1
y = sim(netTreinada, imageInput1);

accuracy = CalculateAccuracy(y, imageTarget1);
fprintf('\nPrecisão total Pasta_1: %f\n', accuracy);

% Simular Pasta_2
y = sim(netTreinada, imageInput2);

accuracy = CalculateAccuracy(y, imageTarget2);
fprintf('\nPrecisão total Pasta_2: %f\n', accuracy);

% Simular Pasta_3
y = sim(netTreinada, imageInput3);

accuracy = CalculateAccuracy(y, imageTarget3);
fprintf('\nPrecisão total Pasta_3: %f\n', accuracy);

% -------------------------------------------------------------------------

% Volte a treinar a rede com todas as imagens fornecidas (Pasta1 + Pasta_2 + Pasta_3).
% Teste a rede para as imagens da Pasta_1, Pasta_2 e Pasta_3 em separado.
% Compare e registe os resultados obtidos.

fprintf('\nTreinar a rede com imagens da (Pasta1 + Pasta_2 + Pasta_3)\n');

imageInput = [imageInput1 imageInput2 imageInput3];
imageTarget = [imageTarget1 imageTarget2 imageTarget3];

[netTreinada, ~] = train(net, imageInput, imageTarget);

% Simular Pasta_1
y = sim(netTreinada, imageInput1);

accuracy = CalculateAccuracy(y, imageTarget1);
fprintf('\nPrecisão total Pasta_1: %f\n', accuracy);

% Simular Pasta_2
y = sim(netTreinada, imageInput2);

accuracy = CalculateAccuracy(y, imageTarget2);
fprintf('\nPrecisão total Pasta_2: %f\n', accuracy);

% Simular Pasta_3
y = sim(netTreinada, imageInput3);

accuracy = CalculateAccuracy(y, imageTarget3);
fprintf('\nPrecisão total Pasta_3: %f\n', accuracy);

net = netTreinada;

save("RedesGravadas/bestNetworkC.mat", 'net');

% -------------------------------------------------------------------------

end

function d()
% Carregar imagens
[imageInput, imageTarget] = GetImages('PastaC/*.jpg', '%d', 0);

% load("RedesGravadas/bestNetworkC.mat", 'net');
% load("RedesGravadas/bestNetworkB.mat", 'net');
% load("RedesGravadas/bestNetworkB 10 tansig traingdx divideint 0.8 0.1 0.1 .mat", 'net');
% load("RedesGravadas/bestNetworkB 10 tansig traingdx dividerand 0.8 0.1 0.1 .mat", 'net');
load("RedesGravadas/bestNetworkB 10 tansig trainlm dividerand 0.8 0.1 0.1 .mat", 'net');

% Simular
y = sim(net, imageInput);

accuracy = CalculateAccuracy(y, imageTarget);
fprintf('\nPrecisão total: %f\n', accuracy);
end
