%% Test out FIS to see if it sucks or not 
% Version 1: tests only the channels considered by the FIS
clc

load ('MyoMex-master\lemurDataSet.mat')
fis = readfis('LemurFingers.fis');

testInput = [...
    features(1,2),
    features(1,3),
    features(1,7),
    features(1,8),
    features(1,1)];

output = evalfis(fis, testInput); %toggle semicolon as desired

outputs = zeros(size(features,1),1);
for i = 1:size(features,1)
        x= [...
            features(i,2), ...
            features(i,3), ...
            features(i,7), ...
            features(i,8), ...
            features(i,1)];
        outputs(i) = evalfis(fis, x); 
end 

%% God save us 
%Order of vectors MUST go 2, 3, 7, 8, 1 to match input order in FIS or
%things get ugly 
ext = [0.2651, 0.0621, 0.0342, 0.0281, 0.1041];
flex = [0.0341, 0.0196, 0.1125, 0.0685, 0.0374];
fist = [0.0459, 0.1316, 0.0708, 0.1861, 0.0810];
splayed = [0.2258, 0.0685, 0.0698, 0.0476, 0.1679];
relaxed = [0.0108, 0.0114, 0.0091, 0.0095, 0.0117]; 

evalfis(fis, ext)
evalfis(fis, flex)
evalfis(fis, fist)
evalfis(fis, splayed)
evalfis(fis, relaxed)

%% DARKNESS IMPRISONING ME 
centers = [10 30 50 70 90];
names = {'Splayed', 'Fist', 'Flexion', 'Extension', 'Relaxed'};
predictions = cell(size(features, 1),1);
for i = 1:size(features,1)
    x = [...
        features(i,2),...
        features(i,3)...
        features(i,7)...
        features(i,8)...
        features(i,1)];
    y = evalfis(fis, x);
    disp(y)
    [~, idx] = min(abs(y-centers));
    disp(idx)
    predictions{i} = names{idx};
end 

correct = 0; 
for i = 1:length(labels)
    if strcmp(predictions{i}, labels{i})
        correct = correct + 1;
    end 
end 

accuracy = correct / length(labels);
fprintf('Accuracy = %.2f%%\n', 100*accuracy) % FUCK 


