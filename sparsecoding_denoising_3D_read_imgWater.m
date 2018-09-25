%% read

imgCase.caseName = 'imgWater3D';
imgCase.caseFolder = fullfile('data');
imgCase.imageMatFile = 'waterImages3D.mat';
imgCase.reconVar = 'ReconBHC';

%%
load(fullfile(imgCase.caseFolder, imgCase.imageMatFile), imgCase.reconVar);
imgOriginal = eval(imgCase.reconVar);
clear(imgCase.reconVar);
imgOriginal = imgOriginal(:,:,1:10);

%%
load(fullfile(imgCase.caseFolder, imgCase.imageMatFile), 'show_win');
imgCase.showWin = show_win;
clear('show_win');

%%
imgCase.seg_thresholds = [-300 300];

%%