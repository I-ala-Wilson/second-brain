# Voice typing for Brain Chat on Windows: local Whisper (faster-whisper, CPU), nothing leaves the computer.
# Creates %USERPROFILE%\.brain-chat\venv and downloads the "small" model (~500 MB).
#   powershell -ExecutionPolicy Bypass -File kit\voice-setup.ps1
$ErrorActionPreference = 'Stop'
$dir = Join-Path $env:USERPROFILE '.brain-chat'
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$venvPy = Join-Path $dir 'venv\Scripts\python.exe'
if (-not (Test-Path $venvPy)) { python -m venv (Join-Path $dir 'venv') }
& $venvPy -m pip install -q --upgrade pip
& $venvPy -m pip install -q faster-whisper sounddevice numpy
Write-Host 'Downloading the Whisper model (~500 MB, one time)...'
& $venvPy -c "from faster_whisper import WhisperModel; import numpy as np; m = WhisperModel('small', device='cpu', compute_type='int8'); list(m.transcribe(np.zeros(16000, dtype=np.float32))[0]); print('ok')"
Write-Host 'Voice typing ready. Press Mic (or Ctrl+M) in Brain Chat.'
