# Claude Code Usage Menu Bar for macOS

A simple SwiftBar plugin that shows your Claude Code usage in the macOS menu bar.

## Setup

1. **Install SwiftBar** (if not already installed):
   ```bash
   brew install --cask swiftbar
   ```

2. **Launch SwiftBar** and choose a plugin folder when prompted (or use `~/Documents/SwiftBarPlugins`)

3. **Copy the plugin** to your SwiftBar plugins folder:
   ```bash
   cp ccusage.30m.sh ~/Documents/SwiftBarPlugins/
   ```

4. The plugin will appear in your menu bar showing today's cost (e.g., 💰 $21.48)

## Features

- Shows today's Claude Code cost in the menu bar
- Updates every 30 minutes (change filename to `ccusage.5m.sh` for 5-minute updates)
- Click to see full usage table with daily breakdown
- Includes refresh button and link to ccusage GitHub

## Requirements

- macOS (Apple Silicon compatible)
- Node.js installed
- SwiftBar app

## Customization

- Change refresh interval by renaming file (e.g., `ccusage.1h.sh` for hourly)
- Edit the script to customize the menu bar display format