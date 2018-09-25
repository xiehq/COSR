function I = combine3DPatches_Padding(X, patchModel, I0, lambda, normalize)

sliceCount = length(patchModel);
regionCount = length(X);
patchSize = size(patchModel{1}.Xtmp{1},1);

I = zeros([size(patchModel{1}.mask{1}) sliceCount]);

for iSlice = 1 : sliceCount
    Xtmp = [];
    idx = ((iSlice-1)*patchSize+1) : (iSlice*patchSize);
    for iRegion = 1 : regionCount
        if ~isempty(X{iRegion})
            Xtmp = [Xtmp X{iRegion}(idx,:)];
        end
    end
    I(:,:,iSlice) = combine2DPatches(Xtmp, patchModel{iSlice}, I0(:,:,iSlice), lambda, normalize);
end

end

