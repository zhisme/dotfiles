# Directory containing your configuration files
CONFIG_DIR="$HOME/.config/zshq"

if [[ -d "$CONFIG_DIR" ]]; then
  for file in "$CONFIG_DIR"/*.zsh; do
    if [[ -f "$file" ]]; then
      source "$file"
    fi
  done
else
  echo "Config directory not found: $CONFIG_DIR"
fi
