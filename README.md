Content-oriented Sparse Representation (CSR) Denoising in CT Images with the Ability of Texture and Edge Preserving
======

This is a demostration MATLAB code package for Content-oriented Sparse Representation (CSR) Denoising in CT Images. 
The CSR denoising method can effectively preserve the noise texture and image edges while reducing the strength of CT image noises. 
It is free to use, distribute, modify and share the package; the only requirement is proper referencing to the authors.

## Some result images

The CSR denoising method compared to the original SR method and others with a water phantom:

![water phantom](https://imgur.com/94OqOiS)

And compared with a pediatric head phantom:

![pediatric head phantom](https://imgur.com/UhadrNE)

## How to install and run the demo codes

(Tested on Windows x64 machines, please [report any issue][1] if it doesnt work in other arch/OS)
 
   - Download or check out the CSRDenoising codes
   
   - Navigate your MATLAB to the CSRDenoising folder
   
   - run Step1_setup_CSR_denoising.m
   
   - run Step2_sparsecoding_denoising_2D.m for 2D image denoising test
   
   - run Step3_sparsecoding_denoising_3D.m for 3D image denoising test
   
If it doesn't work
   
   - Make sure a compiler is set up in your MATLAB. run `mex -setup`. If a 
     compiler is not set up, make sure you download one (some are free)
     and run mex -setup again.
   
   - Read spams-matlab-v2.6\HOW_TO_INSTALL.txt and modify the spams-matlab-v2.6\compile_spams_csrdenoising.m file 
     according to your current OS.

## Change parameter settings of the CSR denoising

   - Some basic settings can be changed right inside the Step2_sparsecoding_denoising_2D.m 
     and Step3_sparsecoding_denoising_3D.m files.
     
   - More settings are in: CSR\sparsecoding_denoising_2D_paramSettings.m and 
     CSR\sparsecoding_denoising_3D_paramSettings.m
     
   - Please refer to our Medical Physics paper for details of these paramters
   
   - Paramters related to the dictinary learning and OMP tools can be found inside: spams-matlab-v2.6\doc_spams_2.6.pdf

## Licensing

This CSRDenoising code package is released under the BSD License, meaning you can use and modify 
the software freely in any case, but you **must** give attribution to the original authors.
For more information, read the license file or the [BSD License Definition][2].

## Contact

If you want to contact us for other reasons than an issue with the tool, please send us an email to

xiehuiqiao[@]gmail.com

## Referencing CSR Denoising

If you use TIGRE in any publications, please reference the following papers:

**(Content-oriented sparse representation (CSR))[3] denoising in CT images**
*Huiqiao Xie, Nadja Kadom, Xiangyang Tang*
**SPIE Medical Imaging 2018, Houston, Texas, United States, 10 - 15 February 2018**

**(Content-oriented Sparse Representation (CSR) Denoising in CT Images with the Ability of Texture and Edge Preserving)[4]**
*Huiqiao Xie, Nadja Kadom, Xiangyang Tang*
*Medical Physics, 2018, Submitted*

## References:

This CSR denoising demo code package uses mexCombinePatches, mexExtractPatches, mexOMP and mexTrainDL of the SPAMS package.

 * J. Mairal, F. Bach, J. Ponce and G. Sapiro. (Online Learning for Matrix Factorization and Sparse Coding)[5]. Journal of Machine Learning Research, volume 11, pages 19-60. 2010.
 * J. Mairal, F. Bach, J. Ponce and G. Sapiro. (Online Dictionary Learning for Sparse Coding. International Conference on Machine Learning)[6], Montreal, Canada, 2009
 * (http://spams-devel.gforge.inria.fr/)[7]
 
---

[1]: https://github.com/xiehq/CSRDenoising/issues
[2]: http://www.linfo.org/bsdlicense.html
[3]: 
[4]: 
[5]: http://www.jmlr.org/papers/volume11/mairal10a/mairal10a.pdf
[6]: http://www.di.ens.fr/willow/pdfs/icml09.pdf
[7]: http://spams-devel.gforge.inria.fr/
