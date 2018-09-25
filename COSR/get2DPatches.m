function [X, patchModel] = get2DPatches(img, patchParam)

if isfield(patchParam,'patch_size_slice') && isfield(patchParam,'patch_step_slice') && ...
        (~isempty(patchParam.patch_size_slice)) && (~isempty(patchParam.patch_step_slice))
    isCalledBy3D = 1;
else
    isCalledBy3D = 0;
end

if patchParam.seg_image
    if ~isfield(patchParam,'seg_thresholds')
        patchParam.seg_thresholds = [];
    end
    if ~isfield(patchParam,'seg_median_filtering')
        patchParam.seg_median_filtering = 0;
    elseif patchParam.seg_median_filtering && ((~isfield(patchParam,'seg_median_filtering_size'))||isempty(patchParam.seg_median_filtering_size))
        patchParam.seg_median_filtering_size = [5 5];
    end
end

if patchParam.seg_image
    if patchParam.seg_median_filtering
        imgSeg = medfilt2(img, patchParam.seg_median_filtering_size, 'symmetric');
    else
        imgSeg = img;
    end
    if isempty(patchParam.seg_thresholds)
        [patchParam.seg_thresholds, ~] = multithresh(imgSeg, 2);
    end
    thresh = [min(imgSeg(:))-1; patchParam.seg_thresholds(:); max(imgSeg(:))+1];
else
    imgSeg = img;
    thresh = [min(imgSeg(:))-1; max(imgSeg(:))+1];
end

X = [];
for i = 1 : (length(thresh)-1)
    mask = (imgSeg>thresh(i)) & (imgSeg<=thresh(i+1));
    if any(~mask(:)) && (~all(~mask(:)))
        imgPatch = regionfill(img, ~mask);
        Xtmp = mexExtractPatches(imgPatch, patchParam.patch_size, patchParam.patch_step);
    elseif all(mask(:))
        imgPatch = img;
        Xtmp = mexExtractPatches(imgPatch, patchParam.patch_size, patchParam.patch_step);
    else
        % imgPatch = [];
        Xtmp = [];
    end
    Mtmp = mexExtractPatches(double(mask), patchParam.patch_size, patchParam.patch_step);
    if ~isCalledBy3D
        idx = find(sum(Mtmp));
        X = [X Xtmp(:,idx)];
        patchModel.idx{i} = idx;
    end
    patchModel.mask{i} = mask;
    if isCalledBy3D
        patchModel.idx{i} = [];
        patchModel.Xtmp{i} = Xtmp;
        patchModel.Mtmp{i} = Mtmp;
    end
end

patchModel.patch_count_orig_img = ...
    length(patchParam.patch_size:patchParam.patch_step:size(img,1)) * ...
    length(patchParam.patch_size:patchParam.patch_step:size(img,2));

patchModel.patch_size = patchParam.patch_size;
patchModel.patch_step = patchParam.patch_step;

end

