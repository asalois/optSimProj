%% Plot and DSP

% Montana State University
% Electrical & Computer Engineering Department
% Created by Alexander Salois
clear; clc; close all;
load('Pam_0001.mat')

ref = real(InNode{1,2}.Signal.samples);
rx = real(InNode{1,1}.Signal.samples);
rx = rx - min(rx);
rx = rx/max(rx);



figure()
hold on
plot(ref)
plot(rx)
hold off

eyediagram(rx,2^pointsPerBit)
eyediagram(ref,2^pointsPerBit)
