function I = combine2DPatches(X, patchModel, I0, lambda, normalize)

I = zeros(size(patchModel.mask{1}));

colXProcessed = 0;
for i = 1 : length(patchModel.idx)
    thisXColCount = length(patchModel.idx{i});
    if thisXColCount > 0
        Xtmp = zeros(size(X,1), patchModel.patch_count_orig_img);
        Xtmp(:,patchModel.idx{i}) = X(:,(colXProcessed+1):(colXProcessed+thisXColCount));
        Itmp = mexCombinePatches(Xtmp,double(I0),patchModel.patch_size,lambda,patchModel.patch_step,normalize);
        I(patchModel.mask{i}) = Itmp(patchModel.mask{i});
        colXProcessed = colXProcessed + thisXColCount;
    end
end

end

