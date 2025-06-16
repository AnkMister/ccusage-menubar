#!/bin/bash

# Claude Code Usage for SwiftBar
# <bitbar.title>Claude Code Usage</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Ankur</bitbar.author>
# <bitbar.desc>Shows Claude Code usage from ccusage</bitbar.desc>
# <bitbar.dependencies>node,npx</bitbar.dependencies>

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
echo "Refresh | refresh=true"
echo "Open ccusage on GitHub | href=https://github.com/ryoppippi/ccusage"