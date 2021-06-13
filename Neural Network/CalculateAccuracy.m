function [accuracy] = CalculateAccuracy(output, input)
numCorrect = 0;
numImages = size(input, 2);
for i = 1 : numImages               % Para cada classificacao
    [~, b] = max(output(:, i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
    [~, d] = max(input(:, i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
    if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
        numCorrect = numCorrect + 1;
    end
end

accuracy = numCorrect / numImages * 100;
end
