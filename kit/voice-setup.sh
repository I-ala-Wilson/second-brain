#!/bin/bash
# Voice typing for Brain Chat on Apple Silicon Macs: local Whisper (MLX), nothing leaves the computer.
# Creates ~/.brain-chat/venv and downloads whisper-large-v3-turbo (~1.5 GB). Run: bash kit/voice-setup.sh
set -euo pipefail
if [ "$(uname -m)" != "arm64" ]; then echo "Voice typing needs an Apple Silicon Mac (M1 or newer)."; exit 1; fi
PY=/usr/bin/python3   # Apple's arm64 Python; Homebrew/pyenv builds are often x86_64 under Rosetta
"$PY" -c 'import platform,sys; sys.exit(platform.machine()!="arm64")' || { echo "Apple's python3 is not arm64. Run xcode-select --install"; exit 1; }
mkdir -p ~/.brain-chat
[ -x ~/.brain-chat/venv/bin/python ] || "$PY" -m venv ~/.brain-chat/venv
~/.brain-chat/venv/bin/pip install -q --upgrade pip
~/.brain-chat/venv/bin/pip install -q mlx-whisper sounddevice numpy
echo "Downloading the Whisper model (~1.5 GB, one time)..."
~/.brain-chat/venv/bin/python - <<'EOF'
import numpy as np, mlx_whisper
mlx_whisper.transcribe(np.zeros(16000, dtype=np.float32), path_or_hf_repo="mlx-community/whisper-large-v3-turbo", language="en")
print("ok")
EOF
echo "Voice typing ready. Press Mic (or Ctrl+M) in Brain Chat. macOS will ask once to allow the microphone for VS Code."
