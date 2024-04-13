FROM nvcr.io/nvidia/pytorch:22.08-py3

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    sudo

# Download and execute the script to add the Git LFS repository
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

# Install Git LFS
RUN sudo apt-get install -y git-lfs

# Setup Git LFS
RUN git lfs install

# Set the working directory
WORKDIR /work

# Set environment variables for CUDA
ENV FORCE_CUDA="1"
ENV TORCH_CUDA_ARCH_LIST="Kepler;Kepler+Tegra;Maxwell;Maxwell+Tegra;Pascal;Volta;Turing"

# Clone the necessary repository
RUN git clone https://github.com/NExT-GPT/NExT-GPT.git /work/NExT-GPT

# Copy your files into the container
COPY redo_json.py WLASL_v0.3.json /work/NExT-GPT/data/IT_data/T+X-T_data/videochat/
COPY videos/ /work/NExT-GPT/data/IT_data/T+X-T_data/videochat/
# Adapt dataset JSON file
RUN python /work/NExT-GPT/data/IT_data/T+X-T_data/videochat/redo_json.py

# Download the Vicuna13b weights
RUN rm -rf /work/NExT-GPT/ckpt/pretrained_ckpt/vicuna_ckpt
RUN git clone https://huggingface.co/helloollel/vicuna-13b /work/NExT-GPT/ckpt/pretrained_ckpt/vicuna_ckpt

# Download the ImageBind weights
RUN curl -o /work/NExT-GPT/ckpt/pretrained_ckpt/imagebind_ckpt/huge/imagebind_huge.pth https://dl.fbaipublicfiles.com/imagebind/imagebind_huge.pth

# Install any additional requirements from the cloned repository
#RUN pip install -r /work/NExT-GPT/requirements.txt
