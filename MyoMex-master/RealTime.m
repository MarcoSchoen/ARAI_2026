clear classes
clear

m1 = MyoMex(1);

figure
for k = 1:8
    subplot (4, 2, k)
    h(k) = plot (nan, nan); 
    title(sprintf('Sensor %d', k));
end 

T = 20;
tStart = tic;

while toc(tStart) < T
    emg = m1.myoData(1).emg_log;
    t = m1.myoData(1).timeEMG_log;

    if size(emg, 1) > 1 
       
       for k = 1:8
            set (h(k),... 
                'XData',t,... 
                'YData',emg(:,k))
           
                
        end 

        drawnow limitrate
    end 

end

delete(m1); 

%Run to observe EMG data collection in real time. 
%Requires init.m to be run succesfully first. 
%% Crucial: Wear the armband such that the inertia sensor (logo one) is aligned with the dorsal plane of the thumb.
