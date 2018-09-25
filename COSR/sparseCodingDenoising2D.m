function varargout = sparseCodingDenoising2D(img, patchParam, paramDL, paramSC, blendLambdaRatio, D)
% 20180524, add computation time measurement of DL and OMP

tm_dl = 0;
tm_omp = 0;

nargoutchk(1,3);
if ~exist('blendLambdaRatio', 'var')
    blendLambdaRatio = 0.0;
end

imgDenoise = zeros(size(img),'like',img);

if exist('D', 'var') && iscell(D) && (length(D)==(length(patchParam.seg_thresholds)+1))
    boolDL = false;
else
    boolDL = true;
end

disp('');
tic_denoising = tic;
for iSlice = 1 : size(img,3)
    tic_slice = tic;
    
    fprintf('2D Sparse Coding Denoising: %d ... ', iSlice);
    
    [X, patchModel] = get2DPatches(double(img(:,:,iSlice)), patchParam);
    
    Xrecover = zeros(size(X),'like',X);
    alpha = {};
    
    patchCountBefore = 0;
    for iMask = 1 : length(patchModel.mask)
        if ~isempty(patchModel.idx{iMask})
            if boolDL
                if length(patchModel.idx{iMask}) >= paramDL.K
                    D{iMask} = X(:,patchCountBefore+randperm(length(patchModel.idx{iMask}),paramDL.K));
                else
                    D{iMask} = X(:,patchCountBefore+randi(length(patchModel.idx{iMask}),1,paramDL.K));
                end
                
                paramDL.D = D{iMask};
                tic_dl = tic;
                D{iMask} = mexTrainDL(X(:,patchCountBefore+(1:length(patchModel.idx{iMask}))), paramDL);
                tm_dl = tm_dl + toc(tic_dl);
            end
            
            if isfield(paramSC,'eps_ratio') && isnumeric(paramSC.eps_ratio)
                paramSC.eps = paramSC.eps_ratio*std(X(:,patchCountBefore+(1:length(patchModel.idx{iMask}))),0,1);
            else
                paramSC.eps = std(X(:,patchCountBefore+(1:length(patchModel.idx{iMask}))),0,1);
            end
            tic_omp = tic;
            alpha{iMask} = mexOMP(X(:,patchCountBefore+(1:length(patchModel.idx{iMask}))), D{iMask}, paramSC);
            tm_omp = tm_omp + toc(tic_omp);
            
            Xrecover(:,patchCountBefore+(1:length(patchModel.idx{iMask}))) = double(D{iMask})*alpha{iMask};
        %else
            %Xrecover = [Xrecover []];
        end
        
        patchCountBefore = patchCountBefore + length(patchModel.idx{iMask});
    end
    
    if nargout >= 2
        varargout{2}{iSlice} = D;
    end
    if nargout == 3
        varargout{3}{iSlice} = alpha;
    end
    
    imgDenoise(:,:,iSlice) = combine2DPatches(Xrecover, patchModel, img(:,:,iSlice), blendLambdaRatio, 1);
    
    fprintf('(%.2fs, DL:%.2fs, OMP:%.2fs)\n', toc(tic_slice), tm_dl, tm_omp);
end

varargout{1} = imgDenoise;

fprintf('\nTotal 2D Denoising: %.2fs\n', toc(tic_denoising));
