%% clear Matlab workspace
% clear workspace and the dictionary D
% clearvars; % 

% do not clear pre-learnt dictionary
clearvars -except D; 

close all;
clc;

%% all settings are put here for convenience of fast changing
% image segmentation, 1: Yes; 0: No 
seg_image = 1;%0;%
% sparsity settings in the sparse coding
sparsity = 1;%2;%5;%
% dictionary size
K = 512;%256*4;%

% % read data and set: [imgCase, imgOriginal, show_win] etc
sparsecoding_denoising_3D_read_imgWater

% image segmentation thresholds,such as: air   |   soft tissues   |   bones
%                                            th(1)             th(2)
seg_thresholds = imgCase.seg_thresholds;

% apply median filtering on the image before segmentation
% default block size : [5 5], 
% block size can be changed in: sparsecoding_denoising_3D_paramSettings.m
seg_median_filtering = 1;

% patch size and step in the z direction
slice_patch_size = 3;
slice_patch_step = 1;

% iteration number of dictionary leraning
iterNumDL = 300;

% T in Eq(4): T = sc_eps_ratio * std(image)
% optional, default value: 1.0 
sc_eps_ratio = 1.0;

% blending ratio of the original image into the denoised image
blendLambdaRatio = 0.0;

%% denoising
% more parameters
sparsecoding_denoising_3D_paramSettings;

% if dictionary is already pre-learnt and exists in the workspace, 
% use the pre-learnt dictionary for denoising
if exist('D', 'var') && iscell(D) && (length(D)==(length(patchParam.seg_thresholds)+1))
    prelearnt_dict = 1;
    imgDenoise = sparseCodingDenoising3DPadding(imgOriginal, patchParam, paramDL, paramSC, blendLambdaRatio, D);
else
    prelearnt_dict = 0;
    imgDenoise = sparseCodingDenoising3DPadding(imgOriginal, patchParam, paramDL, paramSC, blendLambdaRatio);
end

%% show figures
figure;
imshow([imgOriginal(:,:,round(0.5*size(imgOriginal,3))+1) imgDenoise(:,:,round(0.5*size(imgDenoise,3))+1)], imgCase.showWin);

figure;
imshow([squeeze(imgOriginal(round(0.5*size(imgOriginal,1))+1,:,:)); squeeze(imgDenoise(round(0.5*size(imgDenoise,1))+1,:,:))], imgCase.showWin);

figure;
imshow([squeeze(imgOriginal(:,round(0.5*size(imgOriginal,2))+1,:)); squeeze(imgDenoise(:,round(0.5*size(imgDenoise,2))+1,:))], imgCase.showWin);

%% save results, use [imgDenoise, D, alpha, prelearnt_dict] as results

sparsecoding_denoising_3D_write_imgWater;

