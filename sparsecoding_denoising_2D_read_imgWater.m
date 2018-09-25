%%

imgCase.caseName = 'imgWater2D';
imgCase.caseFolder = fullfile('data');
imgCase.imageMatFile = 'waterImages2D.mat';
imgCase.reconVar = 'imgWaterStndHU';% 'imgWaterGaussHU';%

%%
load(fullfile(imgCase.caseFolder, imgCase.imageMatFile), imgCase.reconVar);
imgOriginal = eval(imgCase.reconVar);
clear(imgCase.reconVar);

%%
load(fullfile(imgCase.caseFolder, imgCase.imageMatFile), 'show_win');
imgCase.showWin = show_win;
clear('show_win');

%%
imgCase.seg_thresholds = [-200 50];

%%

