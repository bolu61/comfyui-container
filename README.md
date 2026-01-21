# comfyui-container

A container image for running [ComfyUI](https://github.com/comfyanonymous/ComfyUI), a powerful and modular stable diffusion GUI.

## Features

- Python 3.11 based image
- Pre-configured ComfyUI installation
- Web interface accessible on port 8188
- Support for custom models and nodes

## Building the Container

To build the container image using Podman:

```bash
podman build -t comfyui:latest -f Containerfile .
```

Or using Docker:

```bash
docker build -t comfyui:latest -f Containerfile .
```

## Running the Container

### Basic Usage

Run the container with default settings:

```bash
podman run -p 8188:8188 comfyui:latest
```

Or with Docker:

```bash
docker run -p 8188:8188 comfyui:latest
```

Access the ComfyUI web interface at: `http://localhost:8188`

### Persistent Storage

To persist models and outputs, mount volumes:

```bash
podman run -p 8188:8188 \
  -v ./models:/app/ComfyUI/models \
  -v ./input:/app/ComfyUI/input \
  -v ./output:/app/ComfyUI/output \
  comfyui:latest
```

### Custom Nodes

To use custom nodes, mount the custom_nodes directory:

```bash
podman run -p 8188:8188 \
  -v ./custom_nodes:/app/ComfyUI/custom_nodes \
  comfyui:latest
```

## Directory Structure

- `/app/ComfyUI/models` - Model files (checkpoints, VAE, LoRAs, etc.)
- `/app/ComfyUI/input` - Input images and files
- `/app/ComfyUI/output` - Generated outputs
- `/app/ComfyUI/custom_nodes` - Custom node extensions

## Requirements

- Container runtime (Podman or Docker)
- At least 4GB of RAM (more recommended for larger models)
- GPU support recommended for better performance (requires additional configuration)

## License

See [LICENSE](LICENSE) file for details.
