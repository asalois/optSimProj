%% Get data from Optsim mat files
clear; clc; close all;

OSNR = 50;
runNum = 1;

% load file
loadName = sprintf('pam_snr_%02d_%04d',OSNR,runNum)
load(loadName)

M = 4;

% rescale to work with pamdemod
inSig = real(InNode{1,2}.Signal.samples);
inSig = inSig*6 -3;
outSig = real(InNode{1,1}.Signal.samples);
outSig = outSig - min(outSig);
outSig = outSig/max(outSig);
outSig = outSig*6 -3;

% grab one bit per symbol
grabBit = log2(M)*2^pointsPerBit;
selectIn = inSig(4:grabBit:end);
startOut = floor(grabBit/2);
selectOut = outSig(startOut:grabBit:end);

% demod
bitsIn = pamdemod(selectIn,M);
bitsOut = pamdemod(selectOut,M);

% get BER
[numWrong,ber] = biterr(bitsIn,bitsOut)
