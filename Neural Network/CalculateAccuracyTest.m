function [accuracy] = CalculateAccuracyTest(output, input, tr)
accuracy = CalculateAccuracy(output(:, tr.testInd), input(:, tr.testInd));
end
