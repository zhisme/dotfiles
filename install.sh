#!/usr/bin/env bash

set -e
set -o pipefail

# ~ Ui Helpers
function echo_ok() { echo -e '\033[1;32m'"$1"'\033[0m'; }
function echo_warn() { echo -e '\033[1;33m'"$1"'\033[0m'; }
function echo_error() { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }

# Get the directory where this script is located
dotfiles_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Source directory containing the configuration folders
SOURCE_DIR="$dotfiles_dir/.config"

# Destination directory for .config folders
DEST_CONFIG_DIR="$HOME/.config"

# Ensure the source directory exists
if [[ ! -d "$SOURCE_DIR" ]]; then
  echo_error "Source directory not found: $SOURCE_DIR"
  exit 1
fi

# Ensure the destination directory exists
mkdir -p "$DEST_CONFIG_DIR"

# Iterate over each folder in the source directory
for folder in "$SOURCE_DIR"/*; do
  # Check if it's a directory
  if [[ -d "$folder" ]]; then
    # Extract the folder name (e.g., "alacritty" from ".config/alacritty")
    folder_name=$(basename "$folder")

    # Define the target path for the symlink
    target="$DEST_CONFIG_DIR/$folder_name"

    # Check if the target already exists
    if [[ -e "$target" ]]; then
      echo_warn "Warning: $target already exists. Skipping."
    else
      # Create the symlink
      ln -s "$folder" "$target"
      echo_ok "Symlinked $folder to $target"
    fi
  fi
done

# Iterate over each dotfile in the root directory
for dotfile in "$dotfiles_dir"/.*; do
  # Skip special directories like "." and ".."
  if [[ "$dotfile" == "$dotfiles_dir"/. || "$dotfile" == "$dotfiles_dir"/.. ]]; then
    continue
  fi

  # Check if it's a file
  if [[ -f "$dotfile" ]]; then
    # Extract the file name (e.g., ".zshrc" from "/path/to/.zshrc")
    file_name=$(basename "$dotfile")

    # Define the target path for the dotfile
    target="$HOME/$file_name"

    # Check if the target already exists
    if [[ -e "$target" ]]; then
      echo_warn "Warning: $target already exists. Skipping."
    else
      # Create the symlink
      ln -s "$dotfile" "$target"
      echo_ok "Symlinked $dotfile to $target"
    fi
  fi
done
