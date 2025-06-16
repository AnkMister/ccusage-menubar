#!/bin/bash

# Claude Code Usage for SwiftBar
# <bitbar.title>Claude Code Usage</bitbar.title>
# <bitbar.version>v1.1.0</bitbar.version>
# <bitbar.author>Ankur</bitbar.author>
# <bitbar.desc>Shows Claude Code usage from ccusage</bitbar.desc>
# <bitbar.dependencies>node,npx</bitbar.dependencies>

# Version and update info
CURRENT_VERSION="1.1.0"
GITHUB_REPO="AnkMister/ccusage-menubar"
UPDATE_CHECK_FILE="/tmp/ccusage_last_update_check"

# Run ccusage and capture output
output=$(npx ccusage@latest 2>&1)

# Extract today's date
today=$(date +%Y-%m-%d)

# Extract today's cost from the output using grep and awk
today_cost=$(echo "$output" | grep -E "^\│ $today" | awk -F'│' '{print $NF}' | xargs)

# If we found today's cost, display it; otherwise show total
if [ -n "$today_cost" ]; then
    echo "💰 $today_cost"
else
    # Extract total cost as fallback
    total_cost=$(echo "$output" | grep -E "^\│ Total" | awk -F'│' '{print $NF}' | xargs)
    echo "💰 Total: $total_cost"
fi

echo "---"
echo "Claude Code Usage"
echo "---"

# Display the full output in monospace font
echo "$output" | while IFS= read -r line; do
    # Skip warning messages and loading messages
    if [[ ! "$line" =~ "WARN" ]] && [[ ! "$line" =~ "ExperimentalWarning" ]] && [[ ! "$line" =~ "ℹ Loaded pricing" ]]; then
        echo "$line | font=Menlo size=11"
    fi
done

echo "---"

# Check for updates function
check_for_updates() {
    # Check if we should check for updates (once per day)
    if [ -f "$UPDATE_CHECK_FILE" ]; then
        last_check=$(cat "$UPDATE_CHECK_FILE")
        current_time=$(date +%s)
        # 86400 seconds = 24 hours
        if [ $((current_time - last_check)) -lt 86400 ]; then
            return
        fi
    fi
    
    # Get latest version from GitHub
    latest_version=$(curl -s "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/' 2>/dev/null || echo "")
    
    if [ -n "$latest_version" ] && [ "$latest_version" != "$CURRENT_VERSION" ]; then
        echo "🆕 Update Available (v$latest_version) | color=red"
        echo "-- Click to update | bash='curl -fsSL https://raw.githubusercontent.com/$GITHUB_REPO/main/install.sh | bash' terminal=true"
        echo "---"
    fi
    
    # Update last check time
    date +%s > "$UPDATE_CHECK_FILE"
}

# Check for updates in background
check_for_updates &

echo "Refresh | refresh=true"
echo "Check for Updates | bash='curl -s https://api.github.com/repos/$GITHUB_REPO/releases/latest | grep tag_name' terminal=false"
echo "---"
echo "Open ccusage on GitHub | href=https://github.com/ryoppippi/ccusage"
echo "Open ccusage-menubar on GitHub | href=https://github.com/$GITHUB_REPO"
echo "---"
echo "Version $CURRENT_VERSION | color=gray"