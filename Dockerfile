FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    python3.11 \
    python3-pip

# Python Evn
RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
RUN cd /app/ComfyUI && git checkout v0.3.41
RUN pip3 install -r /app/ComfyUI/requirements.txt

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install libgl1 --yes
RUN apt-get install libglib2.0-dev --yes
RUN apt install build-essential

RUN apt update && \
    apt install -y ffmpeg && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Python Evn
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/city96/ComfyUI-GGUF.git && \
    git clone https://github.com/pythongosssss/ComfyUI-WD14-Tagger.git && \
    git clone https://github.com/TinyTerra/ComfyUI_tinyterraNodes.git && \
    git clone https://github.com/WASasquatch/was-node-suite-comfyui.git && \
    git clone https://github.com/rgthree/rgthree-comfy.git && \
    git clone https://github.com/jax-explorer/ComfyUI-easycontrol.git && \
    git clone https://github.com/kijai/ComfyUI-KJNodes.git && \
    git clone https://github.com/EvilBT/ComfyUI_SLK_joy_caption_two.git && \
    git clone https://github.com/cubiq/ComfyUI_essentials.git && \
    git clone https://github.com/kijai/ComfyUI-IC-Light.git && \
    git clone https://github.com/huchenlei/ComfyUI-IC-Light-Native.git && \
    git clone https://github.com/gseth/ControlAltAI-Nodes.git && \
    git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git && \
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git && \
    git clone https://github.com/chflame163/ComfyUI_LayerStyle.git && \
    git clone https://github.com/justUmen/Bjornulf_custom_nodes.git && \
    git clone https://github.com/Fannovel16/comfyui_controlnet_aux/ && \
    git clone https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git


RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/yolain/ComfyUI-Easy-Use.git && \
    cd ComfyUI-Easy-Use && \
    git checkout 54614079ca96fa66c8953ff89dc66ca77245f5db

RUN cd /app/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack comfyui-impact-pack && \
    cd comfyui-impact-pack && \
    git checkout 705698faf242851881abd7d1e1774baa3cf47136

RUN cd /app/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Subpack && \
    git clone --recursive https://github.com/ssitu/ComfyUI_UltimateSDUpscale

RUN cd /app/ComfyUI/custom_nodes && \
    git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git && \
    git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git && \
    git clone https://github.com/Lightricks/ComfyUI-LTXVideo.git

RUN git clone https://github.com/lakerwe/comfyui_env.git && pip3 install -r /app/comfyui_env/requirements.txt
RUN cp /app/comfyui_env/server.py /app/ComfyUI/server.py

EXPOSE 8848
CMD ["python3", "-u", "/app/ComfyUI/main.py", "--listen", "0.0.0.0", "--port", "8848"]