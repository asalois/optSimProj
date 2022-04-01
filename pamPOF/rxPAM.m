%% PAM Co-Sim RX

% Montana State University
% Electrical & Computer Engineering Department
% Created by Alexander Salois
fiberLength = 10*fiberLength;
saveName = sprintf('pam_%02d_pow_%02d_len_%04d_%04d',M,patternLength,fiberLength,runNum);
save(saveName,'-v7.3')
