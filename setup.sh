#!/usr/bin/env bash
set -e

# ----------------------------
# CONFIG
# ----------------------------
NVIM_DIR="$HOME/.config/nvim"
VIM_DIR="$HOME/.vim"

VIMRC_SOURCE="$NVIM_DIR/vim/vimrc"
VIMRC_TARGET="$VIM_DIR/vimrc"

BACKUP_SUFFIX=".backup.$(date +%s)"

# ----------------------------
# OS DETECTION
# ----------------------------
OS="$(uname -s)"
case "$OS" in
    Linux*)   PLATFORM="linux" ;;
    Darwin*)  PLATFORM="macos" ;;
    MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
    *) echo "Unsupported OS: $OS"; exit 1 ;;
esac

echo "Detected OS: $PLATFORM"

# ----------------------------
# SANITY CHECKS
# ----------------------------
if [ ! -f "$VIMRC_SOURCE" ]; then
    echo "ERROR: $VIMRC_SOURCE does not exist"
    echo "Did you clone the repo to ~/.config/nvim ?"
    exit 1
fi

# ----------------------------
# CREATE DIRECTORIES
# ----------------------------
mkdir -p "$VIM_DIR"

# ----------------------------
# BACKUP EXISTING FILES
# ----------------------------
if [ -e "$VIMRC_TARGET" ] || [ -L "$VIMRC_TARGET" ]; then
    echo "Backing up existing vimrc → ${VIMRC_TARGET}${BACKUP_SUFFIX}"
    mv "$VIMRC_TARGET" "${VIMRC_TARGET}${BACKUP_SUFFIX}"
fi

# ----------------------------
# CREATE SYMLINK
# ----------------------------
ln -s "$VIMRC_SOURCE" "$VIMRC_TARGET"

echo "Symlink created:"
ls -l "$VIMRC_TARGET"

# ----------------------------
# DONE
# ----------------------------
echo
echo "✔ Setup complete"
echo "Vim will load: $VIMRC_TARGET"
echo "Source file : $VIMRC_SOURCE"
