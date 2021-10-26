%% Plot and DSP

% Montana State University
% Electrical & Computer Engineering Department
% Created by Alexander Salois
clear; clc; close all;

%% load files
load('pam_pow_sqPulse_01.mat')
outSig1 = real(InNode{1,1}.Signal.samples);
load('pam_pow_20_len_1000_0010.mat')
rx = real(InNode{1,1}.Signal.samples);
inSig = real(InNode{1,2}.Signal.samples);

%% rescale [0,1]
rx = rx - min(rx);
rx = rx/max(rx);
outSig1 = outSig1 -min(outSig1);
scale = 1/max(outSig1);
filt = outSig1*scale;

%% rescale [-3,3]
rx = (rx -0.5) *6;
inSig = (inSig -0.5) *6;

%% cut
start = 100;
done = 16*100000;
rx = rx(start:start+done);
inSig = inSig(start:start+done);

%% make filter
filt(filt<0.001) = 0;
filt = filt(55:105);
filt = flip(filt);
filt = filt/sum(filt);

%% filter
snr = 100;
delay = 43;
rx_noise = awgn(rx,snr,'measured');
filtSig = filter(filt,1,rx_noise);
filtSig_no = filter(rx,1,rx_noise);
filtSig = filtSig(delay:end);
filtSig_no = filtSig_no(delay:end);
%% plots
% figure()
% hold on
% plot(rx)
% plot(rx_noise)
% hold off
% 
% figure()
% hold on
% plot(rx)
% plot(filtSig)
% hold off

% figure()
% hold on
% plot(inSig)
% plot(filtSig)
% hold off
symPer = 32;
eyediagram(rx,symPer)
% eyediagram(inSig,symPer)
eyediagram(filtSig,symPer)
eyediagram(filtSig_no,symPer)