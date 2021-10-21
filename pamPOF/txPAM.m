%% PAM Co-Sim TX

% Montana State University
% Electrical & Computer Engineering Department
% Created by Alexander Salois

nb = floor((2^patternLength)/log2(M));
msg = randi([0 M-1],1,nb);
tx = pammod(msg,M,0,'gray');
tx = rectpulse(tx,(2^pointsPerBit)*log2(M));
tx = tx/(2*max(tx))+ 1/2;

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

% saveName = sprintf('txPam_%04d',runNum);
% save(saveName)
