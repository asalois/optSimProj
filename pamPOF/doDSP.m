%% Plot and DSP

% Montana State University
% Electrical & Computer Engineering Department
% Created by Alexander Salois
clear; clc; close all;

% load file
len = 100
pick = 33
loadName = sprintf('pam_pow_%02d_len_%04d_%04d',19,len*10,pick)
load(loadName)

% rescale to work with pamdemod
inSig = real(InNode{1,2}.Signal.samples);
inSig = inSig*6 -3;
outSig = real(InNode{1,1}.Signal.samples);
outSig = outSig - min(outSig);
outSig = outSig/max(outSig);
outSig = outSig*6 -3;

%%
% delay = 0;
% 
% inSig = inSig(1:end-delay);
% outSig = outSig(delay+1:end);

M = 4;
grabBit = log2(M)*2^pointsPerBit;
startOut = 8*floor(grabBit/16);

% grab one bit per symbol
selectIn = inSig(4:grabBit:end);
selectOut = outSig(startOut:grabBit:end);

% demod
bitsIn = pamdemod(selectIn,M);
bitsOut = pamdemod(selectOut,M);

% get BER
[numWrong,ber] = biterr(bitsIn,bitsOut)

% sel = 1:2^10;
% figure()
% hold on
% plot(inSig(sel))
% plot(outSig(sel))
% hold off
% 
%%
skip = 1024;
x = 2^16;
figure()
h = subplot(1,2,1)
%eyediagram(inSig(1:x),2*2^pointsPerBit)
eyediagram(outSig(1:x),2*2*2^pointsPerBit,2*2^pointsPerBit,2*2^pointsPerBit/2,'b-',h)
title('100 m with no Noise')
% saveas(gcf,'eye_100_no_noise.png')

h = subplot(1,2,2)
eyediagram(noisy,2*2*2^pointsPerBit,2*2^pointsPerBit,2*2^pointsPerBit/2,'b-',h)
title('100 m with Noise')
% saveas(gcf,'eye_100_noise.png')
