#!/bin/bash

# Test script to verify local installation works

set -e

echo "Testing local installation..."
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Test 1: Check if install script exists and is executable
echo -n "Checking install.sh... "
if [ -f "./install.sh" ] && [ -x "./install.sh" ]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    exit 1
fi

# Test 2: Check if uninstall script exists and is executable
echo -n "Checking uninstall.sh... "
if [ -f "./uninstall.sh" ] && [ -x "./uninstall.sh" ]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    exit 1
fi

# Test 3: Check if main plugin exists and is executable
echo -n "Checking ccusage.30m.sh... "
if [ -f "./ccusage.30m.sh" ] && [ -x "./ccusage.30m.sh" ]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    exit 1
fi

# Test 4: Check if dev-setup script exists and is executable
echo -n "Checking dev-setup.sh... "
if [ -f "./dev-setup.sh" ] && [ -x "./dev-setup.sh" ]; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    exit 1
fi

# Test 5: Verify version consistency
echo -n "Checking version consistency... "
VERSION_FILE=$(cat VERSION)
PLUGIN_VERSION=$(grep "CURRENT_VERSION=" ccusage.30m.sh | cut -d'"' -f2)
INSTALL_VERSION=$(grep "VERSION=" install.sh | grep -v "CURRENT_VERSION" | head -1 | cut -d'"' -f2)

if [ "$VERSION_FILE" = "$PLUGIN_VERSION" ] && [ "$VERSION_FILE" = "$INSTALL_VERSION" ]; then
    echo -e "${GREEN}✓ (v$VERSION_FILE)${NC}"
else
    echo -e "${RED}✗ Version mismatch${NC}"
    echo "  VERSION file: $VERSION_FILE"
    echo "  Plugin version: $PLUGIN_VERSION"
    echo "  Install version: $INSTALL_VERSION"
    exit 1
fi

# Test 6: Check README has correct one-liner
echo -n "Checking README one-liner... "
if grep -q "curl -fsSL https://raw.githubusercontent.com/ankur/ccusage-menubar/main/install.sh | bash" README.md; then
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${RED}✗${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}All tests passed!${NC}"
echo ""
echo "To test the actual installation locally, run:"
echo "  ./install.sh"
echo ""
echo "For development setup, run:"
echo "  ./dev-setup.sh"