# Start from a PyTorch base image with CUDA 11.4 support
FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-devel

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    wget

# Set the working directory
WORKDIR /work

# Copy your files into the container
COPY requirements.txt redo_json.py WLASL_v0.3.json /work/
COPY videos/ /work/videos/

# Set environment variables for CUDA
ENV FORCE_CUDA="1"
ENV TORCH_CUDA_ARCH_LIST="Kepler;Kepler+Tegra;Maxwell;Maxwell+Tegra;Pascal;Volta;Turing"

# Install PyTorch with CUDA 11.4
RUN pip install torch==1.13.1+cu114 torchvision==0.14.1+cu114 torchaudio==0.13.1+cu114 -f https://download.pytorch.org/whl/torch_stable.html

# Install other dependencies from requirements.txt
RUN pip install -r /work/requirements.txt

# Clone the necessary repository
RUN git clone https://github.com/NExT-GPT/NExT-GPT.git /work/NExT-GPT

# Install any additional requirements from the cloned repository
RUN pip install -r /work/NExT-GPT/requirements.txt

# Default command for the container
#CMD ["python", "/work/redo_json.py"]