function varargout = sparseCodingDenoising3DPadding(img, patchParam, paramDL, paramSC, blendLambdaRatio, D)

% 20180524, add computation time measurement of DL and OMP

nargoutchk(1,3);
if ~exist('blendLambdaRatio', 'var')
    blendLambdaRatio = 0.0;
end

imgDenoise = zeros(size(img),'like',img);
sliceAveCount = zeros(1,size(img,3));
X = {};
Xrecover = {};

patchModel = {};
if exist('D', 'var') && iscell(D) && (length(D)==(length(patchParam.seg_thresholds)+1))
    boolDL = false;
else
    D = {};
    boolDL = true;
end
alpha = {};

disp('');
tic_denoising = tic;
for iSlice = patchParam.patch_size_slice : patchParam.patch_step_slice : size(img,3)
    tm_dl = 0;
    tm_omp = 0;

    tic_slice = tic;
    
    sliceList = (iSlice-patchParam.patch_size_slice+1) : iSlice;
    
    fprintf('Denoising Slices: %s ', num2str(sliceList));
    
    [X, patchModel] = get3DPatches_Padding(img(:,:,sliceList), patchParam, patchModel);
    
    for iMask = 1 : length(patchModel{1}.mask)
        if ~isempty(X{iMask})
            if boolDL
                if isempty(D) || (length(D) < iMask)
                    if size(X{iMask},2) >= paramDL.K
                        D{iMask} = X{iMask}(:,randperm(size(X{iMask},2),paramDL.K));
                    else
                        D{iMask} = X{iMask}(:,randi(size(X{iMask},2),1,paramDL.K));
                    end
                end
                
                paramDL.D = D{iMask};
                tic_dl = tic;
                D{iMask} = mexTrainDL(X{iMask}, paramDL);
                tm_dl = tm_dl + toc(tic_dl);
            end
            
            if isfield(paramSC,'eps_ratio') && isnumeric(paramSC.eps_ratio)
                paramSC.eps = paramSC.eps_ratio*std(X{iMask},0,1);
            else
                paramSC.eps = std(X{iMask},0,1);
            end
            tic_omp = tic;
            alpha{iMask} = mexOMP(X{iMask}, D{iMask}, paramSC);
            tm_omp = tm_omp + toc(tic_omp);
            
            Xrecover{iMask} = double(D{iMask})*alpha{iMask};
        else
            Xrecover{iMask} = [];
        end
    end
    
    if nargout >= 2
        varargout{2}{iSlice} = D;
    end
    if nargout == 3
        varargout{3}{iSlice} = alpha;
    end
    
    imgRecover = combine3DPatches_Padding(Xrecover, patchModel, img(:,:,sliceList), blendLambdaRatio, 1);
    imgDenoise(:,:,sliceList) = imgDenoise(:,:,sliceList) + imgRecover;
    sliceAveCount(sliceList) = sliceAveCount(sliceList) + 1;
    
    fprintf('(%.2fs, DL:%.2fs, OMP:%.2fs)\n', toc(tic_slice), tm_dl, tm_omp);
end

for iSlice = 1 : size(imgDenoise,3)
    imgDenoise(:,:,iSlice) = imgDenoise(:,:,iSlice) / sliceAveCount(iSlice);
end

varargout{1} = imgDenoise;

fprintf('\nTotal Denoising: %.2fs\n', toc(tic_denoising));
