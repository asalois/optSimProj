%% Get data from Optsim mat files
clear; clc; close all;

runNum = 1;
berA = ones(10,40);
load('pam_snr_01_len_0001_0001')
M = 4;
for j = 1:10
    for i = 1:40
        % load file
        loadName = sprintf('pam_snr_%02d_len_%04d_%04d',i,j,runNum);
        load(loadName)
        grabBit = log2(M)*2^pointsPerBit;
        startOut = 8*floor(grabBit/16);
        % rescale to work with pamdemod
        inSig = real(InNode{1,2}.Signal.samples);
        inSig = inSig*6 -3;
        outSig = real(InNode{1,1}.Signal.samples);
        outSig = outSig - min(outSig);
        outSig = outSig/max(outSig);
        outSig = outSig*6 -3;
               
        if i == 40 && j==10
            delay = 0;
        else
            delay = 4*2^pointsPerBit;
        end
        
        inSig = inSig(1:end-delay);
        outSig = outSig(delay+1:end);
        
        % grab one bit per symbol
        selectIn = inSig(4:grabBit:end);
        selectOut = outSig(startOut:grabBit:end);
        
        % demod
        bitsIn = pamdemod(selectIn,M);
        bitsOut = pamdemod(selectOut,M);
        
        % get BER
        [numWrong,ber] = biterr(bitsIn,bitsOut);
        berA(j,i) = ber;
    end
end
nnz(berA)

%%
x = 1:40;
figure()
plot(x,berA(1,:),'-*',x,berA(2,:),'-*',x,berA(3,:),'-*',x,berA(4,:),'-*',...
    x,berA(5,:),'-*',x,berA(6,:),'-*',x,berA(7,:),'-*',x,berA(8,:),'-*',....
    x,berA(9,:),'-*',x,berA(10,:),'-*')
legend({'1 m','2 m','3 m','4 m','5 m','6 m','7 m','8 m','9 m','10 m'},'Location','northwest')
xlabel('OSNR [dB]')
ylabel('BER')
title('OSNR vs BER')
