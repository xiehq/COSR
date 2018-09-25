Content‐oriented Sparse Representation (COSR) for CT Denoising with Preservation of Texture and Edge
======

This is a demostration MATLAB code package for Content-oriented Sparse Representation (COSR) Denoising in CT Images. 

The COSR denoising method can effectively preserve the noise texture and image edges while reducing the strength of CT image noises. 

[It is free to use, distribute, modify and share the package for research and personal use; the only requirement is proper referencing to the authors.][2]

## Some result images

The COSR denoising method compared to the original SR method and others with a water phantom:

![water phantom](https://raw.githubusercontent.com/xiehq/COSR/master/figures/img_compare_STND_Gauss_SPIE.jpg)

And compared with a pediatric head image \(see [4] for details\):

![pediatric head image](https://raw.githubusercontent.com/xiehq/COSR/master/figures/denoising_compare_Anon17998_slice2_20180727.jpg)

## How to install and run the demo codes

(Tested on Windows x64 machines, please [report any issue][1] if it does not work in other arch/OS)
 
   - Download or check out the COSR codes
   
   - Navigate your MATLAB to the COSR folder
   
   - run `Step1_setup_COSR_denoising.m`
     - Optional: if using Windows x64 and want to use pre-compiled binaries, comment out Line 7: 
       `compile_spams_cosrdenoising;` in file `compile_and_setup_spams.m`.
       
   - run `Step2_sparsecoding_denoising_2D.m` for 2D image denoising test
   
   - run `Step3_sparsecoding_denoising_3D.m` for 3D image denoising test
   
If it does not work
   
   - Make sure a compiler is set up in your MATLAB. run `mex -setup`. If a 
     compiler is not set up, make sure you download one (some are free)
     and run `mex -setup` again.
   
   - Read `spams-matlab-v2.6\HOW_TO_INSTALL.txt` and modify the `spams-matlab-v2.6\compile_spams_COSR.m` file 
     according to your current OS.

## Change parameter settings of the COSR denoising

   - Some basic settings can be changed right inside the `Step2_sparsecoding_denoising_2D.m` 
     and `Step3_sparsecoding_denoising_3D.m` files.
     
   - More settings are in: `COSR\sparsecoding_denoising_2D_paramSettings.m` and 
     `COSR\sparsecoding_denoising_3D_paramSettings.m`
     
   - Please refer to our Medical Physics paper for details of these paramters
   
   - Paramters related to the dictinary learning and OMP tools can be found inside: `spams-matlab-v2.6\doc_spams_2.6.pdf`

## Contact

If you want to contact us for other reasons, please send us an email to

xiehuiqiao[@]gmail.com

## Referencing COSR Denoising

If you use COSR in any publications, please reference the following papers:

**Content-oriented sparse representation (COSR) denoising in CT images**
*Huiqiao Xie, Nadja Kadom, Xiangyang Tang*
**SPIE Medical Imaging 2018, Houston, Texas, United States, 10 - 15 February 2018**
[Presentation][3], [Proceeding][8]

**[Content-oriented Sparse Representation (COSR) Denoising in CT Images with the Ability of Texture and Edge Preserving][4]**
*Huiqiao Xie, Tianye Niu, Shaojie Tang, Xiaofeng Yang, Nadja Kadom, Xiangyang Tang*
*Medical Physics, 2018, Accepted Author Manuscript*

## References:

This COSR denoising demo code package uses `mexCombinePatches`, `mexExtractPatches`, 
`mexOMP` and `mexTrainDL` of the [SPAMS][7] package.

Just for avoiding any possible compatibility problems of further SPAMS releases, 
SPAMS v2.6 is enclosed with this COSR denoising demo.

 * J. Mairal, F. Bach, J. Ponce and G. Sapiro. [Online Learning for Matrix Factorization and Sparse Coding][5]. Journal of Machine Learning Research, volume 11, pages 19-60. 2010.
 * J. Mairal, F. Bach, J. Ponce and G. Sapiro. [Online Dictionary Learning for Sparse Coding. International Conference on Machine Learning][6], Montreal, Canada, 2009
 * [http://spams-devel.gforge.inria.fr/][7]


[1]: https://github.com/xiehq/COSR/issues
[2]: https://www.gnu.org/licenses/gpl-3.0.en.html
[3]: https://www.spiedigitallibrary.org/conference-proceedings-of-spie/10573/1057328/Content-oriented-sparse-representation-COSR-denoising-in-CT-images/10.1117/12.2293417.short?SSO=1
[4]: https://doi.org/10.1002/mp.13189
[5]: http://www.jmlr.org/papers/volume11/mairal10a/mairal10a.pdf
[6]: http://www.di.ens.fr/willow/pdfs/icml09.pdf
[7]: http://spams-devel.gforge.inria.fr/
[8]: http://spie.org/Publications/Proceedings/Paper/10.1117/12.2293417