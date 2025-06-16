#!/bin/bash

# ccusage-menubar installer script
# This script installs the ccusage SwiftBar plugin

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script info
REPO_URL="https://github.com/AnkMister/ccusage-menubar"
PLUGIN_NAME="ccusage.30m.sh"
VERSION="1.1.0"

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}ccusage-menubar Installer v${VERSION}${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect Mac architecture
detect_architecture() {
    if [[ $(uname -m) == "arm64" ]]; then
        echo "arm64"
    else
        echo "x86_64"
    fi
}

# Check for Node.js
echo -e "${YELLOW}Checking dependencies...${NC}"
if ! command_exists node; then
    echo -e "${RED}Error: Node.js is not installed${NC}"
    echo "Please install Node.js first:"
    echo "  brew install node"
    echo "or download from https://nodejs.org"
    exit 1
fi
echo -e "${GREEN}✓ Node.js is installed${NC}"

# Check for SwiftBar
if ! command_exists swiftbar && ! [ -d "/Applications/SwiftBar.app" ]; then
    echo -e "${YELLOW}SwiftBar is not installed${NC}"
    read -p "Would you like to install SwiftBar via Homebrew? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command_exists brew; then
            echo -e "${BLUE}Installing SwiftBar...${NC}"
            brew install --cask swiftbar
            echo -e "${GREEN}✓ SwiftBar installed${NC}"
        else
            echo -e "${RED}Error: Homebrew is not installed${NC}"
            echo "Please install Homebrew first from https://brew.sh"
            echo "Or install SwiftBar manually from https://github.com/swiftbar/SwiftBar"
            exit 1
        fi
    else
        echo -e "${RED}Error: SwiftBar is required${NC}"
        echo "Please install SwiftBar from https://github.com/swiftbar/SwiftBar"
        exit 1
    fi
else
    echo -e "${GREEN}✓ SwiftBar is installed${NC}"
fi

# Find SwiftBar plugin directory
echo -e "${YELLOW}Finding SwiftBar plugin directory...${NC}"

# Common SwiftBar plugin directories
PLUGIN_DIRS=(
    "$HOME/Library/Application Support/SwiftBar/Plugins"
    "$HOME/Documents/SwiftBarPlugins"
    "$HOME/.swiftbar"
    "$HOME/SwiftBarPlugins"
)

SWIFTBAR_PLUGIN_DIR=""

# Check if SwiftBar is running and try to get plugin directory from preferences
if pgrep -x "SwiftBar" > /dev/null 2>&1; then
    # Try to read SwiftBar preferences
    PREF_DIR=$(defaults read com.ameba.SwiftBar PluginDirectory 2>/dev/null || echo "")
    if [ -n "$PREF_DIR" ] && [ -d "$PREF_DIR" ]; then
        SWIFTBAR_PLUGIN_DIR="$PREF_DIR"
        echo -e "${GREEN}✓ Found SwiftBar plugin directory from preferences: $SWIFTBAR_PLUGIN_DIR${NC}"
    fi
fi

# If not found in preferences, check common directories
if [ -z "$SWIFTBAR_PLUGIN_DIR" ]; then
    for dir in "${PLUGIN_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            SWIFTBAR_PLUGIN_DIR="$dir"
            echo -e "${GREEN}✓ Found existing plugin directory: $SWIFTBAR_PLUGIN_DIR${NC}"
            break
        fi
    done
fi

# If still not found, ask user
if [ -z "$SWIFTBAR_PLUGIN_DIR" ]; then
    echo -e "${YELLOW}No SwiftBar plugin directory found${NC}"
    echo "Please choose an option:"
    echo "1) Use default: ~/Documents/SwiftBarPlugins"
    echo "2) Enter custom path"
    read -p "Choice (1 or 2): " -n 1 -r
    echo
    
    if [[ $REPLY == "2" ]]; then
        read -p "Enter plugin directory path: " SWIFTBAR_PLUGIN_DIR
        # Expand tilde if present
        SWIFTBAR_PLUGIN_DIR="${SWIFTBAR_PLUGIN_DIR/#\~/$HOME}"
    else
        SWIFTBAR_PLUGIN_DIR="$HOME/Documents/SwiftBarPlugins"
    fi
    
    # Create directory if it doesn't exist
    if [ ! -d "$SWIFTBAR_PLUGIN_DIR" ]; then
        echo -e "${BLUE}Creating plugin directory...${NC}"
        mkdir -p "$SWIFTBAR_PLUGIN_DIR"
    fi
fi

# Download and install plugin
echo -e "${YELLOW}Installing ccusage plugin...${NC}"

# Check if we're in a local development environment
if [ -f "./ccusage.30m.sh" ]; then
    echo -e "${BLUE}Found local plugin file, copying...${NC}"
    cp "./ccusage.30m.sh" "$SWIFTBAR_PLUGIN_DIR/$PLUGIN_NAME"
else
    # Download from GitHub
    echo -e "${BLUE}Downloading plugin from GitHub...${NC}"
    curl -fsSL "https://raw.githubusercontent.com/AnkMister/ccusage-menubar/main/ccusage.30m.sh" -o "$SWIFTBAR_PLUGIN_DIR/$PLUGIN_NAME"
fi

# Make executable
chmod +x "$SWIFTBAR_PLUGIN_DIR/$PLUGIN_NAME"

echo -e "${GREEN}✓ Plugin installed successfully${NC}"

# Launch SwiftBar if not running
if ! pgrep -x "SwiftBar" > /dev/null 2>&1; then
    echo -e "${YELLOW}SwiftBar is not running${NC}"
    read -p "Would you like to launch SwiftBar now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        open -a SwiftBar
        echo -e "${GREEN}✓ SwiftBar launched${NC}"
        echo -e "${YELLOW}Note: You may need to select the plugin directory when SwiftBar starts${NC}"
        echo -e "${YELLOW}Plugin directory: $SWIFTBAR_PLUGIN_DIR${NC}"
    fi
else
    echo -e "${GREEN}✓ SwiftBar is already running${NC}"
    echo -e "${YELLOW}The plugin should appear in your menu bar shortly${NC}"
fi

echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Installation complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo "The ccusage plugin is installed at:"
echo "  $SWIFTBAR_PLUGIN_DIR/$PLUGIN_NAME"
echo ""
echo "If you don't see it in your menu bar:"
echo "1. Make sure SwiftBar is running"
echo "2. Check SwiftBar preferences for the correct plugin directory"
echo "3. Try refreshing SwiftBar (click SwiftBar icon → Refresh All)"
echo ""
echo "To customize update frequency, rename the plugin:"
echo "  - ccusage.5m.sh   → Updates every 5 minutes"
echo "  - ccusage.1h.sh   → Updates every hour"
echo "  - ccusage.1d.sh   → Updates once per day"