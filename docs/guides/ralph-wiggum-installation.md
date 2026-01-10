# Installing Ralph Wiggum

This guide covers installing the Ralph Wiggum plugin at the **user level** (`~/.claude/`) so it's available across all your projects.

## Prerequisites

- Claude Code CLI installed and working
- Git (for cloning the plugin)

## Installation Steps

### Step 1: Clone the Plugin

Clone the official Claude Code repository (or just the plugin directory):

```bash
# Option A: Clone just the plugins directory (sparse checkout)
mkdir -p ~/claude-plugins
cd ~/claude-plugins
git clone --depth 1 --filter=blob:none --sparse \
  https://github.com/anthropics/claude-code.git
cd claude-code
git sparse-checkout set plugins/ralph-wiggum

# Option B: Clone the full repo (if you want other plugins too)
cd ~/claude-plugins
git clone https://github.com/anthropics/claude-code.git
```

### Step 2: Install to User-Level Configuration

The plugin needs to be accessible from `~/.claude/`. You can either symlink or copy.

#### Option A: Symlink (Recommended)

Symlinks let you `git pull` to get updates:

```bash
# Create plugins directory if it doesn't exist
mkdir -p ~/.claude/plugins

# Symlink the ralph-wiggum plugin
ln -s ~/claude-plugins/claude-code/plugins/ralph-wiggum ~/.claude/plugins/ralph-wiggum
```

#### Option B: Copy

If you prefer a static copy:

```bash
mkdir -p ~/.claude/plugins
cp -r ~/claude-plugins/claude-code/plugins/ralph-wiggum ~/.claude/plugins/
```

### Step 3: Make Hook Scripts Executable

```bash
chmod +x ~/.claude/plugins/ralph-wiggum/hooks/*.sh
```

### Step 4: Register the Plugin

Add the plugin to your `~/.claude/settings.json`:

```json
{
  "plugins": [
    "~/.claude/plugins/ralph-wiggum"
  ]
}
```

If you already have a `settings.json`, merge the `plugins` array:

```bash
# View current settings
cat ~/.claude/settings.json

# Edit to add the plugin
# (or use jq if you have it installed)
```

### Step 5: Verify Installation

Start a new Claude Code session and run:

```bash
/help ralph
```

You should see the `/ralph-loop` and `/cancel-ralph` commands listed.

## Directory Structure After Installation

```
~/.claude/
├── plugins/
│   └── ralph-wiggum/
│       ├── .claude-plugin/      # Plugin configuration
│       ├── commands/            # /ralph-loop, /cancel-ralph
│       ├── hooks/               # stop-hook.sh
│       ├── scripts/             # Utility scripts
│       └── README.md
├── settings.json                # Contains plugins array
└── ... (other configuration)
```

## Updating Ralph Wiggum

### If Using Symlinks

```bash
cd ~/claude-plugins/claude-code
git pull
```

Changes are immediately available.

### If Using Copy

```bash
cd ~/claude-plugins/claude-code
git pull
cp -r plugins/ralph-wiggum ~/.claude/plugins/
chmod +x ~/.claude/plugins/ralph-wiggum/hooks/*.sh
```

## Troubleshooting

### Commands Not Recognized

1. Restart Claude Code completely
2. Verify the plugin path in settings.json is correct
3. Check the plugin directory exists: `ls ~/.claude/plugins/ralph-wiggum`

### Permission Denied on Hooks

```bash
chmod +x ~/.claude/plugins/ralph-wiggum/hooks/*.sh
```

### Plugin Not Loading

Check your `settings.json` syntax:

```bash
# Validate JSON syntax
cat ~/.claude/settings.json | python3 -m json.tool
```

### Stop Hook Not Triggering

The stop hook requires specific Claude Code versions. Ensure you're running the latest Claude Code:

```bash
claude --version
# Update if needed
```

## Uninstalling

### Remove the Plugin

```bash
rm -rf ~/.claude/plugins/ralph-wiggum
```

### Remove from Settings

Edit `~/.claude/settings.json` and remove the plugin from the `plugins` array.

### Remove Source (Optional)

```bash
rm -rf ~/claude-plugins/claude-code
```

## Next Steps

- [Ralph Wiggum Overview](ralph-wiggum-overview.md) - Understand how it works
- [Preparing and Running Ralph Loops](ralph-wiggum-usage.md) - Start using it
