
%% result mat file name

if ~isdir(imgCase.caseName)
    mkdir(imgCase.caseName);
end

matfile = fullfile(imgCase.caseName, ...
    ['SCD_2D_' imgCase.reconVar ...
    '_SegImg' num2str(patchParam.seg_image) ...
    '_DictSize' num2str(paramDL.K) ...
    '_Sparsity' num2str(paramSC.L)]);% ...
    %'_UseSlice2Dict']);
if prelearnt_dict
    matfile = [matfile '_prelearntD'];
end

%%
save([matfile '.mat'], 'patchParam', 'paramDL', 'paramSC', ...
    'imgCase', 'imgDenoise', 'imgOriginal', ...
    'prelearnt_dict', ...
    '-v7.3');

if exist('D', 'var')
    save([matfile '.mat'], 'D', '-append');
end

if exist('alpha', 'var')
    save([matfile '.mat'], 'alpha', '-append');
end
