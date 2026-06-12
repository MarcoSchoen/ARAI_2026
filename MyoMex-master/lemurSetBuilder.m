%% First section: KNN scatter plot fed by training data 
clear
clc 

features = [];
labels = {};

gestureFolders = {...
    'Myomex-master\EMG Data\Fist', ...
    'Myomex-master\EMG Data\Flexion', ...
    'Myomex-master\EMG Data\Extension', ...
    'Myomex-master\EMG Data\Splayed', ...
    'Myomex-master\EMG Data\Relaxed' };


% open the gates of Hell
for g = 1:length(gestureFolders) % Index; scatter plot likes having a 50x1 matrix as input
  files = dir(fullfile(gestureFolders{g}, '*.mat'));

  for k = 1:length(files)
      filename = fullfile(files(k).folder, files(k).name);
      load(filename); 
      mav = mean(abs(emg_data));
      features = [features; mav]; 
      [~,gestureName] = fileparts(files(k).folder);
      labels{end+1} = gestureName;
 
  end 

end 

size(features)
length(labels)
gscatter(features(:,1),features(:,2),labels')
labels = labels';

disp(features(1:5,:))
disp(labels(1:5))

% Test performance of KNN in classfiying collected EMG data 
mdl = fitcknn(features,labels);
pred = predict(mdl,features); 
mean(strcmp(pred,labels)) %sanity check that MATLAB is classifying training set correctly
cvmdl = crossval(mdl); %Cross-evaluates using already-existing training data to simulate new-point classification. 
loss = kfoldLoss(cvmdl);
accuracy = 1 - loss % returns accuracy value as a percentage. Don't put a semicolon here please my son

%% Produce confusion chart to show which specific classifications were wrong. 
predCV = kfoldPredict(cvmdl);
confusionchart(labels,predCV)

%% Find mean average value for each trial.
gestureNames = unique(labels);
for i = 1:length(gestureNames)
    idx = strcmp(labels, gestureNames{i});
    fprintf ('\n%s\n', gestureNames{i});
    disp (mean(features(idx,:)));
end 
% Output shows mean muscle activation input per Myo Armband sensor and gesture type. 
%% Find true minima and maxima. Modify numbers for desired channel. 
clc
min(features(:,1))
max(features(:,1))

%%
save ('lemurDataSet.mat', 'features', 'labels')