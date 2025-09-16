#!/usr/bin/env bash
# fake-install.sh — simulate apt-style installation for demo/screenshots
# Duration: ~10 minutes (600s), outputs a log every second
# Usage: ./fake-install.sh package1 package2 ...

PACKAGES=("$@")
if [ ${#PACKAGES[@]} -eq 0 ]; then
  echo "Usage: $0 package1 package2 ..."
  exit 1
fi

TOTAL_TIME=600   # 10 minutes
SECONDS=0

echo "Reading package lists... Done"
sleep 1
echo "Building dependency tree"
sleep 1
echo "Reading state information... Done"
sleep 1

MESSAGES=(
  "Selecting previously unselected package..."
  "Preparing to unpack..."
  "Unpacking package files..."
  "Extracting templates..."
  "Expanding archives..."
  "Copying files to system..."
  "Writing configuration files..."
  "Setting up configuration..."
  "Applying default settings..."
  "Updating alternatives..."
  "Processing triggers..."
  "Checking dependencies..."
  "Resolving symbols..."
  "Configuring system services..."
  "Running post-install scripts..."
  "Cleaning up temporary files..."
  "Updating man-db..."
  "Processing triggers for libc-bin..."
  "Linking shared objects..."
  "Generating locales..."
  "Building module cache..."
  "Compiling schemas..."
  "Restarting daemons..."
  "Reloading systemd services..."
  "Updating initramfs..."
  "Processing triggers for dbus..."
  "Verifying checksums..."
  "Marking package as installed..."
  "Fixing broken symlinks..."
  "Optimizing binaries..."
  "Registering MIME types..."
  "Updating desktop database..."
  "Updating icon cache..."
  "Flushing caches..."
  "Finalizing installation..."
  "Synchronizing package metadata..."
  "Rebuilding font cache..."
  "Configuring network services..."
  "Loading kernel modules..."
  "Running ldconfig..."
  "Migrating configuration..."
  "Applying security patches..."
  "Initializing package hooks..."
  "Checking disk space..."
  "Updating certificates..."
  "Rebuilding init scripts..."
  "Purging obsolete files..."
  "Recording installation log..."
  "Installation step completed..."
)

COUNT=${#MESSAGES[@]}
PKG_INDEX=0
MSG_INDEX=0

while [ $SECONDS -lt $TOTAL_TIME ]; do
  pkg="${PACKAGES[$PKG_INDEX]}"
  msg="${MESSAGES[$MSG_INDEX]}"
  percent=$(( SECONDS * 100 / TOTAL_TIME ))

  printf "[%3ds] (%3d%%) %s: %s\n" "$SECONDS" "$percent" "$pkg" "$msg"

  PKG_INDEX=$(( (PKG_INDEX + 1) % ${#PACKAGES[@]} ))
  MSG_INDEX=$(( (MSG_INDEX + 1) % COUNT ))

  sleep 1
done

echo "All packages installed successfully after ${TOTAL_TIME}s."
