%% Plot and DSP

% Montana State University
% Electrical & Computer Engineering Department
% Created by Alexander Salois
clear; clc; close all;
tic
%% load files
load('pam_pow_sqPulse_01.mat')
outSig1 = real(InNode{1,1}.Signal.samples);
load('pam_pow_18_len_0500_0001.mat')
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
done = 16*10000*2;
% done = 16*10*2;
rx = rx(start:start+done);
inSig = inSig(start:start+done);

%% make filter
filt(filt<0.001) = 0;
filt = filt(55:105);
filt = flip(filt);
filt = filt/sum(filt);

%% filter
snr = 15;
delay = 40;
rx_noise = awgn(rx,snr,'measured');
filtSig = filter(filt,1,rx_noise);
filtSig = filtSig(delay:end);
filtSig_no = filter(filt,1,rx);
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
% 
% figure()
% hold on
% plot(inSig)
% plot(filtSig)
% hold off
% toc
%% eyes
symPer = 32;
offset = 12;
eyediagram(rx,symPer,symPer,offset)
saveas(gcf,'eye_noF_noN.png')
eyediagram(filtSig,symPer,symPer,offset)
saveas(gcf,'eye_F_N.png')
eyediagram(filtSig_no,symPer,symPer,offset)
saveas(gcf,'eye_F_noN.png')
toc