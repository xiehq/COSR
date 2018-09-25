%% need to set these params before calling this script

% seg_image = 1;%
% seg_thresholds = [-200 200];%
% seg_median_filtering = 1;
% sparsity = 1;%
% K = 256;%
% iterNumDL = 300;

%% image patch param, see get2DPatches.m and mexExtractPatches.m for more details
clear('patchParam');

% patchParam.seg_image:
% 0: without segmentation of the image; 
% 1: segment the image to three (air,soft,bone) materials
patchParam.seg_image = seg_image;

patchParam.patch_size = 8;
patchParam.patch_step = 1;

% patchParam.seg_thresholds:
% 2x1 vector; (optional) 
% if not presented, the thresholds will be calculated with Otsu's method
patchParam.seg_thresholds = seg_thresholds;

% patchParam.seg_median_filgering
% 0: do not median filter the image before determine the thresholds
% 1: do median filtering before calculating the thresholds
patchParam.seg_median_filtering = seg_median_filtering;
patchParam.seg_median_filtering_size = [5 5]; % optional, default: [5 5]

%% Dictionary Learning param, see mexTrainDL.m for more details
clear('paramDL');

paramDL.mode = 3;%4;
paramDL.lambda = sparsity;%1;%
% param.lambda2 = 0.1;

paramDL.modeD = 0;
paramDL.posD = false;
% param.gamma1 = 0.1;
% param.gamma2 = 0.1;

paramDL.K = K;%256;%max(size(I));%303;%128;%;%256;  % learns a dictionary with 100 elements

paramDL.iter_updateD = 1;

paramDL.posAlpha = false;

paramDL.modeParam = 0;
% param.rho = 0.99;
% param.t0 = 1;

paramDL.clean = true;

paramDL.batchsize=512;

paramDL.iter = iterNumDL;  % iterations.
paramDL.numThreads=-1; % number of threads
paramDL.verbose=false;%true;%

%% sparse coding param, see mexOMP.m for more details
clear('paramSC');

if exist('sc_eps_ratio','var') && isnumeric(sc_eps_ratio)
    paramSC.eps_ratio = sc_eps_ratio;
else
    paramSC.eps_ratio = 1.0;
end

paramSC.L = sparsity;%1;%
% paramSC.eps = paramSC.eps_ratio*mean(std(X,0,1));%1.15*mean(std(X,0,1));%
paramSC.lambda = 0;
paramSC.numThreads = -1;
