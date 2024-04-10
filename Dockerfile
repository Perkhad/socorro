#FROM nvcr.io/nvidia/pytorch:22.03-py3
FROM nvcr.io/nvidia/pytorch:21.08-py3

# Install miniconda ----------------
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y python3.8 pip wget
RUN apt-get update && apt-get install -y git

WORKDIR /work

COPY requirements.txt /work/
COPY redo_json.py /work/
COPY videos/ /work/videos/
COPY WLASL_v0.3.json /work/

ENV FORCE_CUDA="1"
ENV TORCH_CUDA_ARCH_LIST="Kepler;Kepler+Tesla;Maxwell;Maxwell+Tegra;Pascal;Volta;Turing"

RUN pip install -r /work/requirements.txt
RUN git clone https://github.com/NExT-GPT/NExT-GPT.git
RUN pip install -r /work/NExT-GPT/requirements.txt

#ENTRYPOINT  ["python", "/work/sft_trainer.py"]
