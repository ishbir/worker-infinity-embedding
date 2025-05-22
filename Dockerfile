FROM nvcr.io/nvidia/pytorch:25.03-py3 AS base

ENV HF_HOME=/runpod-volume

WORKDIR /workspace

# install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# install python dependencies
COPY requirements.txt requirements.txt
RUN  /root/.local/bin/uv pip install -r requirements.txt --system --break-system-packages

# Add src files
ADD src .

# Add test input
COPY test_input.json test_input.json

# start the handler
CMD python -u handler.py
