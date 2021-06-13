function Main()
clear;
close all;

a();
% b("savedNetwork.mat");
end

function a()
% Carregar imagens
%     [imageInput, imageTarget] = GetImages('Pasta2/*.jpg', 'letter_bnw_%d', 1);
[imageInput, imageTarget] = GetImages('Pasta1/*.jpg', '%d');

% Criar rede neuronal
net = feedforwardnet([10]);

% Fun��o de ativa��o
net.layers{2}.transferFcn = 'tansig';

% Fun��o de treino
net.trainFcn = 'traingdx';

% N�mero de �pocas
net.trainParam.epochs = 1000;

% 
net.divideFcn = '';

% Treino
[net, tr] = train(net, imageInput, imageTarget);

% Simular
%     [imageInput, imageTarget] = GetImages('Pasta1/*.jpg', '%d');
y = sim(net, imageInput);

% accuracy = CalculateAccuracy(y, imageTarget);
% fprintf('Precis�o total: %f\n', accuracy);
%
% accuracyTest = CalculateAccuracy(y(:, tr.testInd), imageTarget(:, tr.testInd));
% fprintf('Precis�o teste: %f\n', accuracyTest);

plotconfusion(imageTarget, y);
end

function b(filename)
transferFcns = ['compet',...
    'hardlim',...
    'hardlims',...
    'logsig',...
    'netinv',...
    'poslin',...
    'purelin',...
    'radbas',...
    'radbasn',...
    'satlin',...
    'satlins',...
    'softmax',...
    'tansig',...
    'tribas'];

trainFcns = ['trainbfg',...
    'trainbfgc',...
    'trainbr',...
    'trainbu',...
    'trainc',...
    'traincgb',...
    'traincgf',...
    'traincgp',...
    'traingd',...
    'traingda',...
    'traingdm',...
    'traingdx',...
    'trainlm',...
    'trainoss',...
    'trainr',...
    'trainrp',...
    'trainru',...
    'trains'];

if (~exist(filename, 'file'))
    % Carregar imagens
    [imageInput, imageTarget] = GetImages('Pasta2/*.jpg', 'letter_bnw_%d', 1);
    %     [imageInput, imageTarget] = GetImages('Pasta1/*.jpg', '%d');
    
    % Criar rede neuronal
    net = feedforwardnet([10]);
    
    % Fun��o de ativa��o
    net.layers{2}.transferFcn = 'tansig';
    
    % Fun��o de treino
    net.trainFcn = 'traingdx';
    
    % N�mero de �pocas
    net.trainParam.epochs = 1000;
    
    %
    net.divideFcn = '';
    
    % Treino
    [net, tr] = train(net, imageInput, imageTarget);
    
    % Simular
    %     [imageInput, imageTarget] = GetImages('Pasta1/*.jpg', '%d');
    y = sim(net, imageInput);
    
    accuracy = CalculateAccuracy(y, imageTarget);
    fprintf('Precis�o total: %f\n', accuracy);
    
    accuracyTest = CalculateAccuracyTest(y, imageTarget, tr);
    fprintf('Precis�o teste: %f\n', accuracyTest);
else
    load(filename);
end

save(filename);

plotconfusion(imageTarget, y);
end
