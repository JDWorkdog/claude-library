#!/bin/bash
# Claude Library - Symlink Installation Script
# Creates symbolic links from ~/.claude/ to this repository

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIBRARY_DIR="$(dirname "$SCRIPT_DIR")"
CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$HOME/.claude.backup.$(date +%Y%m%d_%H%M%S)"

echo "╔════════════════════════════════════════════╗"
echo "║  Claude Library - Symlink Installation     ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "Library location: $LIBRARY_DIR"
echo "Install location: $CLAUDE_DIR"
echo ""

# Check if ~/.claude exists and has content
if [ -d "$CLAUDE_DIR" ]; then
    # Check for existing symlinks (might be re-running)
    if [ -L "$CLAUDE_DIR/agents" ]; then
        echo "⚠️  Existing symlinks detected. Re-linking..."
        rm -f "$CLAUDE_DIR/agents" "$CLAUDE_DIR/skills" "$CLAUDE_DIR/commands" "$CLAUDE_DIR/hooks"
    else
        # Backup existing configuration
        echo "📦 Backing up existing ~/.claude/ to $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"

        # Only backup directories that will be replaced
        [ -d "$CLAUDE_DIR/agents" ] && cp -r "$CLAUDE_DIR/agents" "$BACKUP_DIR/"
        [ -d "$CLAUDE_DIR/skills" ] && cp -r "$CLAUDE_DIR/skills" "$BACKUP_DIR/"
        [ -d "$CLAUDE_DIR/commands" ] && cp -r "$CLAUDE_DIR/commands" "$BACKUP_DIR/"
        [ -d "$CLAUDE_DIR/hooks" ] && cp -r "$CLAUDE_DIR/hooks" "$BACKUP_DIR/"
        [ -f "$CLAUDE_DIR/settings.json" ] && cp "$CLAUDE_DIR/settings.json" "$BACKUP_DIR/"

        # Remove directories to be replaced
        rm -rf "$CLAUDE_DIR/agents" "$CLAUDE_DIR/skills" "$CLAUDE_DIR/commands" "$CLAUDE_DIR/hooks"
    fi
else
    echo "📁 Creating ~/.claude/ directory"
    mkdir -p "$CLAUDE_DIR"
fi

# Create symlinks
echo ""
echo "🔗 Creating symlinks..."

ln -sf "$LIBRARY_DIR/personal/agents" "$CLAUDE_DIR/agents"
echo "   ✅ agents -> $LIBRARY_DIR/personal/agents"

ln -sf "$LIBRARY_DIR/personal/skills" "$CLAUDE_DIR/skills"
echo "   ✅ skills -> $LIBRARY_DIR/personal/skills"

ln -sf "$LIBRARY_DIR/personal/commands" "$CLAUDE_DIR/commands"
echo "   ✅ commands -> $LIBRARY_DIR/personal/commands"

ln -sf "$LIBRARY_DIR/personal/hooks" "$CLAUDE_DIR/hooks"
echo "   ✅ hooks -> $LIBRARY_DIR/personal/hooks"

# Handle settings.json (merge if exists)
echo ""
echo "⚙️  Configuring settings..."

if [ -f "$CLAUDE_DIR/settings.json" ]; then
    echo "   Found existing settings.json - merging hooks configuration"
    # For now, just notify user. In production, use jq to merge
    echo "   ⚠️  Please manually merge hooks from personal/settings.json"
else
    cp "$LIBRARY_DIR/personal/settings.json" "$CLAUDE_DIR/settings.json"
    echo "   ✅ Created settings.json with hooks configuration"
fi

# Make hooks executable
echo ""
echo "🔐 Setting hook permissions..."
chmod +x "$LIBRARY_DIR/personal/hooks/"*.sh 2>/dev/null || true
echo "   ✅ Hooks are executable"

# Summary
echo ""
echo "╔════════════════════════════════════════════╗"
echo "║  Installation Complete!                    ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "Installed components:"
echo "  • Agents: $(ls -1 "$LIBRARY_DIR/personal/agents/"*.md 2>/dev/null | wc -l | tr -d ' ') agents"
echo "  • Skills: $(ls -1d "$LIBRARY_DIR/personal/skills/"*/ 2>/dev/null | wc -l | tr -d ' ') skills"
echo "  • Commands: $(ls -1 "$LIBRARY_DIR/personal/commands/"*.md 2>/dev/null | wc -l | tr -d ' ') commands"
echo "  • Hooks: $(ls -1 "$LIBRARY_DIR/personal/hooks/"*.sh 2>/dev/null | wc -l | tr -d ' ') hooks"
echo ""
echo "To update, simply run: git pull"
echo ""
if [ -d "$BACKUP_DIR" ]; then
    echo "📦 Backup saved to: $BACKUP_DIR"
fi
