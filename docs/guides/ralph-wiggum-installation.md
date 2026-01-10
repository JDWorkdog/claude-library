# Installing Ralph Loop (Ralph Wiggum)

This guide covers installing the Ralph Loop plugin, which implements the "Ralph Wiggum technique" for iterative AI development loops.

## Quick Install (Recommended)

Ralph Loop is available in the official Claude Code marketplace. Installation takes seconds:

### Step 1: Open Plugin Browser

In any Claude Code session, run:

```
/plugin
```

### Step 2: Search and Install

1. Type `ralph` to filter
2. Select `ralph-loop` from `claude-plugins-official`
3. Press **Space** to install

### Step 3: Verify Installation

```
/ralph-loop:help
```

You should see the available commands:
- `/ralph-loop:ralph-loop <prompt>` - Start a loop
- `/ralph-loop:cancel-ralph` - Cancel an active loop

That's it! The plugin is now available in all your Claude Code sessions.

## Alternative: Settings-Based Installation

You can also enable the plugin via `~/.claude/settings.json` for automatic installation:

```json
{
  "enabledPlugins": {
    "ralph-loop@claude-plugins-official": true
  }
}
```

This ensures the plugin is always enabled, even in new sessions.

## Updating

The plugin updates automatically from the marketplace. No action needed.

## Uninstalling

### Via Plugin Browser

```
/plugin
```

Find `ralph-loop` and press **Space** to uninstall.

### Via Settings

Remove the entry from `enabledPlugins` in your settings.json:

```json
{
  "enabledPlugins": {
    "ralph-loop@claude-plugins-official": true  // Remove this line
  }
}
```

## Next Steps

- [Ralph Wiggum Overview](ralph-wiggum-overview.md) - Understand how it works
- [Preparing and Running Ralph Loops](ralph-wiggum-usage.md) - Start using it
