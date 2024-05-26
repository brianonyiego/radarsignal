% Parameters
fc_radar = 10e9;        % Radar carrier frequency (Hz)
T_radar = 10e-6;        % Radar pulse duration (s)
B_radar = 20e6;         % Radar bandwidth (Hz)
fs_radar = 100e6;       % Radar sampling frequency (Hz)
max_range = 5000;       % Maximum detection range (m)
fc_jammer = 10e9;       % Jammer carrier frequency (Hz)
T_jammer = 10e-6;       % Jammer pulse duration (s)
B_jammer = 20e6;        % Jammer bandwidth (Hz)
fs_jammer = 100e6;      % Jammer sampling frequency (Hz)
c = 3e8;                % Speed of light (m/s)

% Time vector for radar signal
t_radar = 0:1/fs_radar:T_radar-1/fs_radar;

% Generate radar signal (LFM)
radar_signal = chirp(t_radar, fc_radar, T_radar, fc_radar + B_radar/2, 'linear', 90); 

% Plot radar signal
figure;
plot(t_radar, real(radar_signal));
xlabel('Time (s)');
ylabel('Amplitude');
title('Radar Signal (LFM)');

% Range vector for radar signal
R_radar = linspace(0, max_range, length(t_radar));

% Simulate radar signal reception
received_signal = radar_signal .* exp(1j * 2 * pi * (fc_radar * 2 * R_radar / c));

% Plot received radar signal
figure;
plot(t_radar, real(received_signal));
xlabel('Time (s)');
ylabel('Amplitude');
title('Received Radar Signal (LFM)');

% Generate Barker code modulation
barker_code = [+1, +1, +1, -1, -1, +1, -1];
barker_modulated = repmat(barker_code, 1, ceil(length(t_radar)/length(barker_code)));
barker_modulated = barker_modulated(1:length(t_radar));

% Generate jammer signal (LFM)
t_jammer = 0:1/fs_jammer:T_jammer-1/fs_jammer;
jammer_signal = chirp(t_jammer, fc_jammer, T_jammer, fc_jammer + B_jammer/2, 'linear', 90); 

% Plot jammer signal
figure;
plot(t_jammer, real(jammer_signal));
xlabel('Time (s)');
ylabel('Amplitude');
title('Jammer Signal (LFM)');

% Range vector for jammer signal
R_jammer = linspace(0, max_range, length(t_jammer));

% Modulate jammer signal with Barker code
jammer_signal_modulated = jammer_signal .* barker_modulated;

% Plot modulated jammer signal
figure;
plot(t_jammer, real(jammer_signal_modulated));
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated Jammer Signal (LFM + Barker Code)');

% Amplify jammer signal (optional)
amplified_jammer_signal = jammer_signal_modulated; % No amplification for simplicity

% Simulate jammer signal transmission
received_jammer_signal = amplified_jammer_signal .* exp(1j * 2 * pi * (fc_jammer * 2 * R_radar / c));

% Plot received jammer signal
figure;
plot(t_jammer, real(received_jammer_signal));
xlabel('Time (s)');
ylabel('Amplitude');
title('Received Jammer Signal (LFM + Barker Code)');
