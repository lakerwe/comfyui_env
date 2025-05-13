FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    python3.11 \
    python3-pip

# Python Evn
RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121   
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
RUN cd /app/ComfyUI && git checkout v0.3.29
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
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/city96/ComfyUI-GGUF.git
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/yolain/ComfyUI-Easy-Use.git
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/pythongosssss/ComfyUI-WD14-Tagger.git   
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/TinyTerra/ComfyUI_tinyterraNodes.git    
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/WASasquatch/was-node-suite-comfyui.git  
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/rgthree/rgthree-comfy.git
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/jax-explorer/ComfyUI-easycontrol.git    
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/kijai/ComfyUI-KJNodes.git

RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/EvilBT/ComfyUI_SLK_joy_caption_two.git  
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/cubiq/ComfyUI_essentials.git
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/kijai/ComfyUI-IC-Light.git
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/huchenlei/ComfyUI-IC-Light-Native.git   
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/gseth/ControlAltAI-Nodes.git
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git        
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/chflame163/ComfyUI_LayerStyle.git       
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/justUmen/Bjornulf_custom_nodes.git      
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git        

RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/mit-han-lab/ComfyUI-nunchaku nunchaku_nodes
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/Fannovel16/comfyui_controlnet_aux/
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git
RUN cd /app/ComfyUI/custom_nodes && git clone https://github.com/kijai/ComfyUI-FramePackWrapper.git


RUN git clone https://github.com/lakerwe/comfyui_env.git
RUN pip3 install -r /app/comfyui_env/requirements.txt
RUN pip3 install https://huggingface.co/mit-han-lab/nunchaku/resolve/main/nunchaku-0.2.0+torch2.7-cp310-cp310-linux_x86_64.whl

EXPOSE 8848
CMD ["python3", "-u", "/app/ComfyUI/main.py", "--listen", "0.0.0.0", "--port", "8848"]