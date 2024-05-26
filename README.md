# radarsignal
# MATLAB Radar and Jammer Signal Simulation

This MATLAB script simulates radar and jammer signals using Linear Frequency Modulation (LFM) and Barker code modulation. It demonstrates the generation, transmission, and reception of both radar and jammer signals. The script includes visualization of these signals in the time domain.

## Table of Contents
1. [Overview](#overview)
2. [Parameters](#parameters)
3. [Radar Signal Generation](#radar-signal-generation)
4. [Radar Signal Reception](#radar-signal-reception)
5. [Jammer Signal Generation and Modulation](#jammer-signal-generation-and-modulation)
6. [Jammer Signal Reception](#jammer-signal-reception)
7. [Visualization](#visualization)

## Overview
This script is divided into sections that handle different parts of the simulation:
1. Setting up parameters for radar and jammer signals.
2. Generating radar and jammer signals using LFM.
3. Modulating the jammer signal with a Barker code.
4. Simulating the reception of radar and jammer signals.
5. Visualizing the generated and received signals.

## Parameters
The parameters for the radar and jammer signals are defined as follows:

```matlab
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
```

## Radar Signal Generation
The radar signal is generated using LFM with the `chirp` function. The time vector `t_radar` is defined based on the radar pulse duration and sampling frequency.

```matlab
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
```

## Radar Signal Reception
The received radar signal is simulated by applying a phase shift based on the range `R_radar`.

```matlab
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
```

## Jammer Signal Generation and Modulation
The jammer signal is also generated using LFM and then modulated with a Barker code. The Barker code is repeated to match the length of the time vector `t_jammer`.

```matlab
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

% Modulate jammer signal with Barker code
jammer_signal_modulated = jammer_signal .* barker_modulated;

% Plot modulated jammer signal
figure;
plot(t_jammer, real(jammer_signal_modulated));
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated Jammer Signal (LFM + Barker Code)');
```

## Jammer Signal Reception
The received jammer signal is simulated similarly to the radar signal, considering the phase shift based on the range.

```matlab
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
```

## Visualization
The script includes several `figure` commands to visualize the radar and jammer signals in the time domain. These plots help in understanding the characteristics of the generated and received signals.

By running this script in MATLAB, you can simulate and analyze radar and jammer signals, visualize their waveforms, and observe the effects of modulation and reception. Adjust the parameters and modulation schemes to explore different scenarios and enhance your understanding of radar and electronic warfare systems.
