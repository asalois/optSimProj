%% PAM Co-Sim TX

% Montana State University
% Electrical & Computer Engineering Department
% Created by Alexander Salois

noPoints = 2^noSamples;
tx = zeros(1,noPoints);
symPer = (2^pointsPerBit)*log2(M);
middle = length(tx)/2;
if M == 0
	tx(middle) = 1;
else
	tx(middle-symPer/2:middle+symPer/2) = 2/3;
end
	
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
