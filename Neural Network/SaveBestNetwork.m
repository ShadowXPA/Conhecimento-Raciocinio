function [net, accuracy, accuracyTest] = SaveBestNetwork(fileName, net, accuracy, accuracyTest)
if (exist(fileName, 'file'))
    netNew = net;
    accuracyNew = accuracy;
    accuracyTestNew = accuracyTest;
    load(fileName, 'net', 'accuracy', 'accuracyTest');
    if (accuracyNew >= accuracy && accuracyTestNew > accuracyTest)
        net = netNew;
        accuracy = accuracyNew;
        accuracyTest = accuracyTestNew;
    end
end
save(fileName, 'net', 'accuracy', 'accuracyTest');
end
