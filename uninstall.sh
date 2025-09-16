#!/usr/bin/env bash
# uninstall.sh — removes 'fake-install' and its files

set -euo pipefail

REPO_NAME="fake-install-logger"

paths=(
  "/usr/local/bin/fake-install"
  "/usr/local/share/${REPO_NAME}/fake-install.sh"
  "$HOME/.local/bin/fake-install"
  "$HOME/.local/share/${REPO_NAME}/fake-install.sh"
)

for p in "${paths[@]}"; do
  if [ -e "$p" ]; then
    if [ -w "$p" ]; then
      rm -rf "$p"
    else
      sudo rm -rf "$p" || true
    fi
    echo "Removed: $p"
  fi
done

# Remove empty share directories
for d in "/usr/local/share/${REPO_NAME}" "$HOME/.local/share/${REPO_NAME}"; do
  if [ -d "$d" ]; then
    if [ -w "$d" ]; then
      rmdir "$d" 2>/dev/null || true
    else
      sudo rmdir "$d" 2>/dev/null || true
    fi
  fi
done

echo "✅ Uninstall complete."
