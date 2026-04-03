FROM python:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /opt

# Clone ComfyUI repository
ARG VERSION=v0.18.2
ADD https://github.com/Comfy-Org/ComfyUI/archive/refs/tags/$VERSION.tar.gz /tmp/comfyui.tar.gz
RUN mkdir comfyui && tar -xzf /tmp/comfyui.tar.gz -C comfyui --strip-components=1 && rm /tmp/comfyui.tar.gz 

# Set working directory to ComfyUI
WORKDIR /opt/comfyui

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt 

# Create directories for models, inputs, and outputs
RUN mkdir -p models/checkpoints models/vae models/loras models/controlnet \
    models/clip models/unet models/clip_vision models/style_models \
    models/embeddings models/diffusers models/vae_approx \
    input output custom_nodes

# Expose ComfyUI web interface port
EXPOSE 8188

# Set the command to run ComfyUI
CMD ["python", "main.py", "--listen", "0.0.0.0", "--port", "8188"]
