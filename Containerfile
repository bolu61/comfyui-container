# Use Python 3.11 slim image as base
FROM python:3.11-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    COMFYUI_VERSION=master

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    wget \
    curl \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone ComfyUI repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /app/ComfyUI

# Set working directory to ComfyUI
WORKDIR /app/ComfyUI

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
