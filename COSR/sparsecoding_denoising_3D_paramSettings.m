%% need to set these params before calling this script

% seg_image = 1;%1;% 
% seg_thresholds = [-150 150];%[-200 200];
% seg_median_filtering = 1;
% sparsity = 3;%2;%1;%3;%5;%10;%
% slice_patch_size = 3;
% slice_patch_step = 1;
% K = 256*2;%2;%
% iterNumDL = 300;%100;%200;%


%% image patch param, see get3DPatches_Padding.m and mexExtractPatches.m for more details
clear('patchParam');

% patchParam.seg_image:
% 0: without segmentation of the image; 
% 1: segment the image to three (air,soft,bone) materials
patchParam.seg_image = seg_image;

patchParam.patch_size = 8;
patchParam.patch_step = 1;

% patch size and step in the z direction
patchParam.patch_size_slice = slice_patch_size;
patchParam.patch_step_slice = slice_patch_step;

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
paramDL.lambda = sparsity;%1;%0.1;%0.15;
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

paramDL.iter = iterNumDL;  % let us see what happens after 1000 iterations.
paramDL.numThreads=-1; % number of threads
paramDL.verbose=false;%true;%

%% sparse coding param, see mexOMP.m for more details
clear('paramSC');

if exist('sc_eps_ratio','var') && isnumeric(sc_eps_ratio)
    paramSC.eps_ratio = sc_eps_ratio;
else
    paramSC.eps_ratio = 1.0;
end

paramSC.L = sparsity;%2;%2;%10;% min(size(D));%1;%
% paramSC.eps = 1.15*mean(std(X,0,1));%1;%1e-3;%0;%
paramSC.lambda = 0;
paramSC.numThreads = -1;

