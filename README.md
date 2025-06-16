# Claude Code Usage Menu Bar for macOS

A simple SwiftBar plugin that shows your Claude Code usage in the macOS menu bar.

![Menu Bar Preview](https://user-images.githubusercontent.com/placeholder.png)

## Features

- 💰 Shows today's Claude Code cost in the menu bar
- 📊 Click to see full usage table with daily breakdown
- 🔄 Auto-updates every 30 minutes (customizable)
- 🆕 Self-updating with version checking
- 🍎 Full support for Intel and Apple Silicon Macs

## Quick Install

Run this one-liner in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/ankur/ccusage-menubar/main/install.sh | bash
```

This will:
- Check for and install dependencies (Node.js required, SwiftBar optional)
- Download and install the ccusage plugin
- Launch SwiftBar if needed

## Manual Installation

If you prefer to install manually:

1. **Install SwiftBar** (if not already installed):
   ```bash
   brew install --cask swiftbar
   ```

2. **Install Node.js** (if not already installed):
   ```bash
   brew install node
   ```

3. **Download the plugin**:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/ankur/ccusage-menubar/main/ccusage.30m.sh -o ~/Documents/SwiftBarPlugins/ccusage.30m.sh
   chmod +x ~/Documents/SwiftBarPlugins/ccusage.30m.sh
   ```

4. Launch SwiftBar and select your plugin directory

## Developer Setup

For development, symlink the plugin instead of copying:

```bash
# Clone the repository
git clone https://github.com/ankur/ccusage-menubar.git
cd ccusage-menubar

# Create symlink to SwiftBar plugins directory
ln -sf "$(pwd)/ccusage.30m.sh" ~/Documents/SwiftBarPlugins/ccusage.30m.sh

# Make sure it's executable
chmod +x ccusage.30m.sh
```

Now you can edit the plugin file and changes will be reflected immediately after refresh.

## Customization

### Update Frequency

The plugin updates every 30 minutes by default. To change this, rename the file:

- `ccusage.5s.sh` → Updates every 5 seconds (not recommended)
- `ccusage.1m.sh` → Updates every minute
- `ccusage.5m.sh` → Updates every 5 minutes
- `ccusage.30m.sh` → Updates every 30 minutes (default)
- `ccusage.1h.sh` → Updates every hour
- `ccusage.1d.sh` → Updates once per day

Example:
```bash
cd ~/Documents/SwiftBarPlugins
mv ccusage.30m.sh ccusage.5m.sh
```

### Display Format

Edit the script to customize what appears in the menu bar. The default shows today's cost, but you can modify it to show:
- Total cost
- Weekly cost
- Custom emoji
- Different formatting

## Updates

The plugin automatically checks for updates once per day. When an update is available:
- You'll see a "🆕 Update Available" notification in the menu
- Click it to update automatically

You can also manually check for updates from the menu.

## Uninstall

To remove the plugin:

```bash
curl -fsSL https://raw.githubusercontent.com/ankur/ccusage-menubar/main/uninstall.sh | bash
```

Or manually delete the plugin file from your SwiftBar plugins directory.

## Troubleshooting

### Plugin not appearing in menu bar

1. Make sure SwiftBar is running
2. Check that the plugin is in the correct directory
3. Verify the plugin is executable: `chmod +x ~/Documents/SwiftBarPlugins/ccusage.30m.sh`
4. Click SwiftBar icon → Refresh All

### "command not found: node" error

Install Node.js:
```bash
brew install node
```

### Cost not updating

1. Check your internet connection
2. Verify ccusage works in terminal: `npx ccusage@latest`
3. Check SwiftBar logs for errors

## Requirements

- macOS (Intel or Apple Silicon)
- Node.js 14+ 
- SwiftBar app
- Active Claude Code subscription

## Contributing

Pull requests welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

MIT - see [LICENSE](LICENSE) file

## Credits

- Built on top of [ccusage](https://github.com/ryoppippi/ccusage) by @ryoppippi
- Uses [SwiftBar](https://github.com/swiftbar/SwiftBar) for menu bar integration