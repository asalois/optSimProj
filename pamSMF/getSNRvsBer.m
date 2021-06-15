%% Get data from Optsim mat files
clear all; clc; close all;

OSNR = 40;
runNum = 1;
loadName = sprintf('pam_snr_%02d_%04d',OSNR,runNum)
load(loadName)

inSig = real(InNode{1,2}.Signal.samples);
inSig = inSig - min(inSig);
inSig = inSig/max(inSig);
outSig = real(InNode{1,1}.Signal.samples);
outSig = outSig - min(outSig);
outSig = outSig/max(outSig);
%% plot
figure()
hold on;
plot(inSig)
plot(outSig)
hold off;
