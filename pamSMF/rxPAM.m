%% PAM Co-Sim RX

% Montana State University
% Electrical & Computer Engineering Department
% Created by Alexander Salois
fiberLength = 10*fiberLength;
saveName = sprintf('pam_snr_%02d_len_%04d_%04d',OSNR,fiberLength,runNum);
save(saveName)
