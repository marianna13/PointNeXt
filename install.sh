#!/usr/bin/env bash
# command to install this enviroment: source init.sh

# install miniconda3 if not installed yet.
#wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
#bash Miniconda3-latest-Linux-x86_64.sh
#source ~/.bashrc


# The following 4 lines are only for slurm machines. uncomment if needed.  
# export TORCH_CUDA_ARCH_LIST="6.1;6.2;7.0;7.5;8.0"   # a100: 8.0; v100: 7.0; 2080ti: 7.5; titan xp: 6.1
# module purge
# module load cuda/11.3.1
# module load gcc/7.5.0

# download openpoints
git clone https://github.com/guochengqian/openpoints.git /content/PointNeXt/openpoints
# git submodule add git@github.com:guochengqian/openpoints.git
# git submodule update --init --recursive
# git submodule update --remote --merge # update to the latest version

# install PyTorch


# please always double check installation for pytorch and torch-scatter from the official documentation

pip install torch-scatter -f https://data.pyg.org/whl/torch-1.13.0+cu116.html

pip install -r requirements.txt
pip install shortuuid

# install cpp extensions, the pointnet++ library
cd openpoints/cpp/pointnet2_batch
python setup.py install
cd ../

# grid_subsampling library. necessary only if interested in S3DIS_sphere
cd subsampling
python setup.py build_ext --inplace
cd ..


# # point transformer library. Necessary only if interested in Point Transformer and Stratified Transformer
cd pointops/
python setup.py install
cd ..

# Blow are functions that optional. Necessary only if interested in reconstruction tasks such as completion
cd chamfer_dist
python setup.py install --user
cd ../emd
python setup.py install --user
cd ../../../