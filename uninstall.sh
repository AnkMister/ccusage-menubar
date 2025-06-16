#!/bin/bash

# ccusage-menubar uninstaller script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}ccusage-menubar Uninstaller${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# Common SwiftBar plugin directories
PLUGIN_DIRS=(
    "$HOME/Library/Application Support/SwiftBar/Plugins"
    "$HOME/Documents/SwiftBarPlugins"
    "$HOME/.swiftbar"
    "$HOME/SwiftBarPlugins"
)

# Find installed plugins
echo -e "${YELLOW}Searching for ccusage plugins...${NC}"
FOUND_PLUGINS=()

for dir in "${PLUGIN_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        # Look for any ccusage plugin files
        for plugin in "$dir"/ccusage*.sh; do
            if [ -f "$plugin" ]; then
                FOUND_PLUGINS+=("$plugin")
            fi
        done
    fi
done

if [ ${#FOUND_PLUGINS[@]} -eq 0 ]; then
    echo -e "${YELLOW}No ccusage plugins found${NC}"
    echo "Nothing to uninstall."
    exit 0
fi

echo -e "${GREEN}Found ${#FOUND_PLUGINS[@]} ccusage plugin(s):${NC}"
for plugin in "${FOUND_PLUGINS[@]}"; do
    echo "  - $plugin"
done
echo ""

read -p "Do you want to remove all ccusage plugins? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled."
    exit 0
fi

# Remove plugins
echo -e "${YELLOW}Removing plugins...${NC}"
for plugin in "${FOUND_PLUGINS[@]}"; do
    rm -f "$plugin"
    echo -e "${GREEN}✓ Removed: $plugin${NC}"
done

# Clean up temporary files
echo -e "${YELLOW}Cleaning up temporary files...${NC}"
rm -f /tmp/ccusage_last_update_check
echo -e "${GREEN}✓ Temporary files cleaned${NC}"

echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Uninstall complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo "The ccusage-menubar plugin has been removed."
echo ""
echo "Note: SwiftBar itself was not removed."
echo "To remove SwiftBar, run: brew uninstall --cask swiftbar"