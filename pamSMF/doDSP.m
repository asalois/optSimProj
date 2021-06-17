%% Plot and DSP

% Montana State University
% Electrical & Computer Engineering Department
% Created by Alexander Salois
clear; clc; close all;

% load file
loadName = sprintf('pam_snr_%02d_len_%04d_%04d',40,9,1)
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

sel = 1:2^10;
figure()
hold on
plot(inSig(sel))
plot(outSig(sel))
hold off
% 
% %%
% eyediagram(inSig,2^pointsPerBit)
% eyediagram(outSig,2^pointsPerBit)
