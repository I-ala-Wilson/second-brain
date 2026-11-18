# Second Brain installer for Windows. Run from the brain folder:
#   powershell -ExecutionPolicy Bypass -File kit\install.ps1
# Checks Claude Code and Python, installs the Brain Chat VS Code extension, and reports what it did.
$ErrorActionPreference = 'Continue'
Set-Location (Join-Path $PSScriptRoot '..')
$Repo = 'I-ala-Wilson/second-brain'
function Ok($m) { Write-Host "  ok    $m" }
function Todo($m) { Write-Host "  TODO  $m" }

Write-Host 'Second Brain installer'

# 1. Claude Code CLI
$bundled = Get-ChildItem "$env:USERPROFILE\.vscode\extensions\anthropic.claude-code-*\resources\native-binary\claude.exe" -ErrorAction SilentlyContinue
if ((Get-Command claude -ErrorAction SilentlyContinue) -or (Test-Path "$env:USERPROFILE\.local\bin\claude.exe") -or $bundled) {
  Ok 'Claude Code found'
} else {
  Write-Host '  ...   installing Claude Code (official installer)'
  try { Invoke-RestMethod https://claude.ai/install.ps1 | Invoke-Expression; Ok 'Claude Code installed' } catch { Todo 'Claude Code install failed. Run: irm https://claude.ai/install.ps1 | iex' }
}

# 2. Python 3
$py = Get-Command python -ErrorAction SilentlyContinue
if ($py -and ($py.Source -notmatch 'WindowsApps')) {
  Ok ("Python " + (& python -c "import platform; print(platform.python_version())"))
} elseif (Get-Command winget -ErrorAction SilentlyContinue) {
  Write-Host '  ...   installing Python 3.12 with winget'
  winget install -e --id Python.Python.3.12 --accept-source-agreements --accept-package-agreements --silent | Out-Null
  Todo 'Python installed. Close and reopen VS Code so it is on PATH.'
} else {
  Todo 'Python missing. Install it from https://www.python.org/downloads/ (tick "Add to PATH").'
}

# 3. VS Code command line tool
$code = Get-Command code -ErrorAction SilentlyContinue
if (-not $code) {
  foreach ($p in @("$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd", "$env:ProgramFiles\Microsoft VS Code\bin\code.cmd")) { if (Test-Path $p) { $code = $p; break } }
} else { $code = $code.Source }
if (-not $code) { Todo 'VS Code not found. Install it from https://code.visualstudio.com, then run this again.'; exit 0 }
Ok 'VS Code found'

# 4. Brain Chat extension
$vsix = Join-Path $env:TEMP 'brain-chat.vsix'
try {
  Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/$Repo/releases/latest/download/brain-chat.vsix" -OutFile $vsix
  & $code --install-extension $vsix --force | Out-Null
  Ok 'Brain Chat installed'
} catch {
  Todo 'Could not download Brain Chat (no internet, or the repo is private).'
}

Write-Host ''
Write-Host "Next: reload VS Code (Ctrl+Shift+P, then 'Reload Window') with this folder open."
Write-Host 'Brain Chat opens by itself and starts the setup interview.'
