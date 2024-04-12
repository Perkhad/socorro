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

# Copy your files into the container
COPY redo_json.py WLASL_v0.3.json /work/
COPY videos/ /work/videos/

# Set environment variables for CUDA
ENV FORCE_CUDA="1"
ENV TORCH_CUDA_ARCH_LIST="Kepler;Kepler+Tegra;Maxwell;Maxwell+Tegra;Pascal;Volta;Turing"

# Clone the necessary repository
RUN git clone https://github.com/NExT-GPT/NExT-GPT.git /work/NExT-GPT

# Install any additional requirements from the cloned repository
#RUN pip install -r /work/NExT-GPT/requirements.txt
