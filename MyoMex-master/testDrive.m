clear 
clc 

load('MyoMex-master\EMG Data\Fist\fist1.mat')
size('emg_data')
mav = mean(abs(emg_data));
disp(mav)
%Generates a 1x8 feature vector for the data specified in "load." 