#!/bin/bash
# Second Brain installer for macOS. Run from the brain folder: bash kit/install.sh
# Checks Claude Code and Python, installs the Brain Chat VS Code extension, and reports what it did.
set -uo pipefail
cd "$(dirname "$0")/.."
REPO="I-ala-Wilson/second-brain"
ok() { printf '  ok    %s\n' "$1"; }
todo() { printf '  TODO  %s\n' "$1"; }

echo "Second Brain installer"

# 1. Claude Code CLI (Brain Chat runs every chat through it)
if command -v claude >/dev/null 2>&1 || [ -x "$HOME/.local/bin/claude" ] || ls "$HOME"/.vscode/extensions/anthropic.claude-code-*/resources/native-binary/claude >/dev/null 2>&1; then
  ok "Claude Code found"
else
  echo "  ...   installing Claude Code (official installer)"
  if curl -fsSL https://claude.ai/install.sh | bash >/dev/null 2>&1; then ok "Claude Code installed"; else todo "Claude Code install failed. Run: curl -fsSL https://claude.ai/install.sh | bash"; fi
fi

# 2. Python 3 (reminder hook, code runner, voice typing)
if command -v python3 >/dev/null 2>&1 && python3 -c 'import sys' >/dev/null 2>&1; then
  ok "Python $(python3 -c 'import platform; print(platform.python_version())')"
else
  todo "Python 3 missing. Run: xcode-select --install   (then run this installer again)"
fi

# 3. VS Code command line tool
CODE=""
for c in code "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" "$HOME/Downloads/Visual Studio Code.app/Contents/Resources/app/bin/code"; do
  if command -v "$c" >/dev/null 2>&1 || [ -x "$c" ]; then CODE="$c"; break; fi
done
if [ -z "$CODE" ]; then
  todo "VS Code not found. Install it from https://code.visualstudio.com, then run this installer again."
  exit 0
fi
ok "VS Code found"

# 4. Brain Chat extension from the latest release
VSIX="$(mktemp -d)/brain-chat.vsix"
if curl -fsSL -o "$VSIX" "https://github.com/$REPO/releases/latest/download/brain-chat.vsix"; then
  if "$CODE" --install-extension "$VSIX" --force >/dev/null 2>&1; then ok "Brain Chat installed"; else todo "Brain Chat install failed. In VS Code: Extensions > ... > Install from VSIX, pick $VSIX"; fi
else
  todo "Could not download Brain Chat (no internet, or the repo is private)."
fi

echo
echo "Next: reload VS Code (Cmd+Shift+P, then 'Reload Window') with this folder open."
echo "Brain Chat opens by itself and starts the setup interview."
