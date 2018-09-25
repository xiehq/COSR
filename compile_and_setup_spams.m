%% compile and setup
% step 1: navigate Matlab to SPAMS folder: 'spams-matlab-v2.6'
cd('spams-matlab-v2.6');

% step 2: run 'compile.m' 
%         (optional if using Windows x64 and want to use pre-compiled binaries)
compile_spams_cosrdenoising;

% step 3: run 'start_spams.m'
start_spams;

cd('..');

%% more details 
% see 'HOW_TO_INSTALL.txt', 'HOW_TO_USE.txt' and 'doc_spams_2.6.pdf' for more
% details about the SPAMS package.

%% References:
%
%     "Online Learning for Matrix Factorization and Sparse Coding"
%     by Julien Mairal, Francis Bach, Jean Ponce and Guillermo Sapiro
%     arXiv:0908.0050
%     
%     "Online Dictionary Learning for Sparse Coding"      
%     by Julien Mairal, Francis Bach, Jean Ponce and Guillermo Sapiro
%     ICML 2009.
%
%     http://spams-devel.gforge.inria.fr/
%     