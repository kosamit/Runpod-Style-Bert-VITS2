FROM pytorch/pytorch:2.2.2-cuda12.1-cudnn8-runtime
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y build-essential libssl-dev libffi-dev cmake git wget ffmpeg nvidia-cuda-toolkit libatlas-base-dev gfortran git-lfs
RUN pip3 uninstall -y cmake
RUN git lfs install

WORKDIR /
RUN git clone https://github.com/litagin02/Style-Bert-VITS2.git
RUN mv Style-Bert-VITS2 /app

WORKDIR /app/model_assets
RUN git clone https://huggingface.co/ayousanz/tsukuyomi-chan-style-bert-vits2-model

WORKDIR /app/model_assets/tsukuyomi-chan-style-bert-vits2-model
RUN rm tsukuyomi-chan_e39_s1000.safetensors
RUN rm tsukuyomi-chan_e77_s2000.safetensors
# RUN rm tsukuyomi-chan_e116_s3000.safetensors
RUN rm tsukuyomi-chan_e154_s4000.safetensors
RUN rm tsukuyomi-chan_e193_s5000.safetensors
RUN rm tsukuyomi-chan_e200_s5200.safetensors

WORKDIR /app
RUN pip3 install -r requirements.txt
RUN pip3 install runpod
ENV LD_LIBRARY_PATH /opt/conda/lib/python3.10/site-packages/nvidia/cublas/lib:/opt/conda/lib/python3.10/site-packages/nvidia/cudnn/lib:${LD_LIBRARY_PATH}
RUN python initialize.py --skip_jvnv


RUN git clone https://github.com/kosamit/Runpod-Style-Bert-VITS2.git

RUN mv Runpod-Style-Bert-VITS2/start.sh .
RUN mv Runpod-Style-Bert-VITS2/runpod_handler.py .
RUN chmod +x start.sh

CMD [ "./start.sh" ]
