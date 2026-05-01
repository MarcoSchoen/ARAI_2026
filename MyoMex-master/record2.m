%% Record2: Ensure that the Myo Armband is on and completely synced with the Armband Manager actively running before running this file.

T = 5; % seconds

m1 = MyoMex(1);    % starts streaming automatically

pause(T);          % collect data

% Copies data before deletion
imu_time = m1.myoData(1).timeIMU_log;
emg_time = m1.myoData(1).timeEMG_log;
emg_data = m1.myoData(1).emg_log;

delete(m1);        %don't really know what this does lmao but it won't work without it

fprintf('Logged data for %d seconds,\n\t',T);
fprintf('IMU samples: %10d\tApprox. IMU sample rate: %5.2f\n\t',...
  length(imu_time), length(imu_time)/T);

fprintf('EMG samples: %10d\tApprox. EMG sample rate: %5.2f\n\t',...
  length(emg_time), length(emg_time)/T);

%% Prepare data
EMGT = [emg_data, emg_time];

% Save as text
folder = 'C:\Users\dthir\Desktop\MyoMex-master\MyoMex-master\MyoMex\';
filename = fullfile(folder, 'data_0_0.txt');

save(filename, 'EMGT', '-ascii');

%% Results?
figure;
plot(emg_time, emg_data);
title('EMG (all channels)');

figure;
for i = 1:8
    subplot(4,2,i);
    plot(emg_time, emg_data(:,i));
    title(['EMG Channel ', num2str(i)]);
xlabel('Time (s)');
ylabel('Signal');
end