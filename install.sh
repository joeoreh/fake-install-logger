#!/usr/bin/env bash
# install.sh — installs 'fake-install' into PATH via curl | bash one-liner
# Usage (for users):
#   curl -fsSL https://raw.githubusercontent.com/YOUR_GH_USER/fake-install-logger/main/install.sh | bash

set -euo pipefail

REPO_USER="YOUR_GH_USER"
REPO_NAME="fake-install-logger"
RAW_BASE="https://raw.githubusercontent.com/${REPO_USER}/${REPO_NAME}/main"

# Choose install locations (root vs user)
if command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null || [ "$(id -u)" -eq 0 ]; then
  BIN_DIR="/usr/local/bin"
  SHARE_DIR="/usr/local/share/${REPO_NAME}"
  USE_SUDO="$( [ "$(id -u)" -ne 0 ] && echo sudo || true )"
else
  BIN_DIR="${HOME}/.local/bin"
  SHARE_DIR="${HOME}/.local/share/${REPO_NAME}"
  USE_SUDO=""
  mkdir -p "${HOME}/.local/bin"
fi

echo "Installing to:"
echo "  BIN_DIR   = ${BIN_DIR}"
echo "  SHARE_DIR = ${SHARE_DIR}"

# Create directories
${USE_SUDO} mkdir -p "${BIN_DIR}"
${USE_SUDO} mkdir -p "${SHARE_DIR}"

# Download main script
echo "Downloading fake-install.sh ..."
curl -fsSL "${RAW_BASE}/fake-install.sh" -o /tmp/fake-install.sh

# Install files
${USE_SUDO} mv /tmp/fake-install.sh "${SHARE_DIR}/fake-install.sh"
${USE_SUDO} chmod +x "${SHARE_DIR}/fake-install.sh"

# Create launcher in BIN_DIR
LAUNCHER="${BIN_DIR}/fake-install"
echo "Creating launcher at ${LAUNCHER}"
cat <<'EOF' >/tmp/fake-install
#!/usr/bin/env bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
# Try common share dirs to find the real script:
CANDIDATES=(
  "/usr/local/share/fake-install-logger/fake-install.sh"
  "$HOME/.local/share/fake-install-logger/fake-install.sh"
)
for s in "${CANDIDATES[@]}"; do
  if [ -f "$s" ]; then
    exec bash "$s" "$@"
  fi
done
echo "fake-install script not found. Reinstall with the install.sh." >&2
exit 1
EOF

${USE_SUDO} mv /tmp/fake-install "${LAUNCHER}"
${USE_SUDO} chmod +x "${LAUNCHER}"

# PATH hint for non-root installs
if [ -z "${USE_SUDO}" ]; then
  if ! echo "$PATH" | grep -q "${BIN_DIR}"; then
    echo
    echo "NOTE: ${BIN_DIR} is not in your PATH."
    echo "Add this line to your shell profile (~/.bashrc or ~/.zshrc):"
    echo "  export PATH=\"${BIN_DIR}:\$PATH\""
  fi
fi

echo
echo "✅ Installed. Try:"
echo "  fake-install nginx git curl"
