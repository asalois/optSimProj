%% PAM Co-Sim

% Montana State University
% Electrical & Computer Engineering Department
% Created by Alexander Salois

nb = 2^patternLength;
msg = randi([0 M-1],1,nb);
tx = pammod(msg,M);
tx = rectpulse(tx,2^pointsPerBit);

noPoints = 2^noSamples;
OutNode{1}.noSignals = 1;
OutNode{1}.Signal.noPoints = noPoints;
OutNode{1}.Signal.samples = complex(tx');
OutNode{1}.Signal.sigma = complex(zeros(1,noPoints));
OutNode{1}.Signal.tStep = timeStep;
OutNode{1}.Signal.startTime = 0;
OutNode{1}.Signal.bitRate = bitRate;
OutNode{1}.Signal.signalType = 2;
OutNode{1}.Signal.noiseRep = noiseRepEnum.Undefined;
OutNode{1}.Signal.patternLength = 2^patternLength;

save txPAM
