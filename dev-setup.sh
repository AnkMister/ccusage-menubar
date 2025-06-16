#!/bin/bash

# Developer setup script for ccusage-menubar
# This script creates a symlink for development

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}ccusage-menubar Developer Setup${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# Get the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PLUGIN_FILE="$SCRIPT_DIR/ccusage.30m.sh"

# Check if plugin file exists
if [ ! -f "$PLUGIN_FILE" ]; then
    echo -e "${RED}Error: ccusage.30m.sh not found in current directory${NC}"
    exit 1
fi

# Common SwiftBar plugin directories
PLUGIN_DIRS=(
    "$HOME/Library/Application Support/SwiftBar/Plugins"
    "$HOME/Documents/SwiftBarPlugins"
    "$HOME/.swiftbar"
    "$HOME/SwiftBarPlugins"
)

# Find or create SwiftBar plugin directory
SWIFTBAR_PLUGIN_DIR=""
for dir in "${PLUGIN_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        SWIFTBAR_PLUGIN_DIR="$dir"
        break
    fi
done

if [ -z "$SWIFTBAR_PLUGIN_DIR" ]; then
    SWIFTBAR_PLUGIN_DIR="$HOME/Documents/SwiftBarPlugins"
    echo -e "${YELLOW}Creating SwiftBar plugin directory: $SWIFTBAR_PLUGIN_DIR${NC}"
    mkdir -p "$SWIFTBAR_PLUGIN_DIR"
fi

# Create symlink
SYMLINK_PATH="$SWIFTBAR_PLUGIN_DIR/ccusage.30m.sh"

# Remove existing file/symlink if it exists
if [ -e "$SYMLINK_PATH" ] || [ -L "$SYMLINK_PATH" ]; then
    echo -e "${YELLOW}Removing existing plugin at: $SYMLINK_PATH${NC}"
    rm -f "$SYMLINK_PATH"
fi

echo -e "${BLUE}Creating symlink...${NC}"
ln -sf "$PLUGIN_FILE" "$SYMLINK_PATH"
echo -e "${GREEN}✓ Symlink created${NC}"

# Make sure it's executable
chmod +x "$PLUGIN_FILE"

echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Developer setup complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo "Symlink created:"
echo "  $SYMLINK_PATH → $PLUGIN_FILE"
echo ""
echo "You can now edit the plugin file and changes will be"
echo "reflected immediately after refreshing SwiftBar."
echo ""
echo "To test changes:"
echo "1. Edit ccusage.30m.sh"
echo "2. Click SwiftBar icon → Refresh All"