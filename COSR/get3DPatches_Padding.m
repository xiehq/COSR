function [X, patchModel] = get3DPatches_Padding(img, patchParam, patchModel)

if exist('patchModel','var') && (~isempty(patchModel))
    for iSlice = (patchParam.patch_step_slice+1) : patchParam.patch_size_slice
        patchModel{iSlice-patchParam.patch_step_slice} = patchModel{iSlice};
    end
    for iSlice = 1 : patchParam.patch_step_slice
        [~, patchModel{end-iSlice+1}] = get2DPatches(img(:,:,end-iSlice+1), patchParam);
    end
else
    for iSlice = 1 : patchParam.patch_size_slice
        [~, patchModel{iSlice}] = get2DPatches(img(:,:,iSlice), patchParam);
    end
end

X = {};
for iRegion = 1 : length(patchModel{1}.mask)
    X{iRegion} = [];
    Mtmp = [];
    for iSlice = 1 : patchParam.patch_size_slice
        Mtmp = [Mtmp; patchModel{iSlice}.Mtmp{iRegion}];
    end
    idx = find(sum(Mtmp));
    if ~isempty(idx)
        for iSlice = 1 : patchParam.patch_size_slice
            if isempty(patchModel{iSlice}.Xtmp{iRegion})
                for iSliceTmp = 1 : patchParam.patch_size_slice
                    if ~isempty(patchModel{iSliceTmp}.Xtmp{iRegion})
                        break;
                    end
                end
                X{iRegion} = [X{iRegion}; patchModel{iSliceTmp}.Xtmp{iRegion}(:,idx)];
            else
                X{iRegion} = [X{iRegion}; patchModel{iSlice}.Xtmp{iRegion}(:,idx)];
                patchModel{iSlice}.idx{iRegion} = idx;
            end
        end
    else
        % X{iRegion} = [];
        patchModel{iSlice}.idx{iRegion} = [];
    end
end

end

