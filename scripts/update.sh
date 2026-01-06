#!/bin/bash
# Claude Library - Update Script
# Updates ~/.claude/ from the latest library version (for copy installations)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIBRARY_DIR="$(dirname "$SCRIPT_DIR")"
CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$HOME/.claude.backup.$(date +%Y%m%d_%H%M%S)"

echo "╔════════════════════════════════════════════╗"
echo "║  Claude Library - Update                   ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# Check if using symlinks (no update needed)
if [ -L "$CLAUDE_DIR/agents" ]; then
    echo "✅ You're using symlink installation."
    echo "   Simply run 'git pull' in the library directory to update."
    echo ""
    echo "   cd $LIBRARY_DIR && git pull"
    exit 0
fi

# Check if ~/.claude exists
if [ ! -d "$CLAUDE_DIR" ]; then
    echo "❌ No ~/.claude/ directory found."
    echo "   Please run install.sh or install-copy.sh first."
    exit 1
fi

# Pull latest changes
echo "📥 Pulling latest changes..."
cd "$LIBRARY_DIR"
git pull

# Show what will be updated
echo ""
echo "📋 Changes to be applied:"
echo ""

# Compare files (simplified - just show counts)
echo "   Library agents: $(ls -1 "$LIBRARY_DIR/personal/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')"
echo "   Installed agents: $(ls -1 "$CLAUDE_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')"
echo ""

# Ask for confirmation
read -p "Do you want to proceed with the update? (y/N) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Update cancelled."
    exit 0
fi

# Backup current installation
echo ""
echo "📦 Backing up current installation to $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
cp -r "$CLAUDE_DIR/agents" "$BACKUP_DIR/" 2>/dev/null || true
cp -r "$CLAUDE_DIR/skills" "$BACKUP_DIR/" 2>/dev/null || true
cp -r "$CLAUDE_DIR/commands" "$BACKUP_DIR/" 2>/dev/null || true
cp -r "$CLAUDE_DIR/hooks" "$BACKUP_DIR/" 2>/dev/null || true
cp "$CLAUDE_DIR/settings.json" "$BACKUP_DIR/" 2>/dev/null || true

# Update files
echo ""
echo "📋 Updating files..."

rm -rf "$CLAUDE_DIR/agents" "$CLAUDE_DIR/skills" "$CLAUDE_DIR/commands" "$CLAUDE_DIR/hooks"

cp -r "$LIBRARY_DIR/personal/agents" "$CLAUDE_DIR/agents"
echo "   ✅ Updated agents/"

cp -r "$LIBRARY_DIR/personal/skills" "$CLAUDE_DIR/skills"
echo "   ✅ Updated skills/"

cp -r "$LIBRARY_DIR/personal/commands" "$CLAUDE_DIR/commands"
echo "   ✅ Updated commands/"

cp -r "$LIBRARY_DIR/personal/hooks" "$CLAUDE_DIR/hooks"
echo "   ✅ Updated hooks/"

# Make hooks executable
chmod +x "$CLAUDE_DIR/hooks/"*.sh 2>/dev/null || true

# Summary
echo ""
echo "╔════════════════════════════════════════════╗"
echo "║  Update Complete!                          ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "Updated components:"
echo "  • Agents: $(ls -1 "$CLAUDE_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ') agents"
echo "  • Skills: $(ls -1d "$CLAUDE_DIR/skills/"*/ 2>/dev/null | wc -l | tr -d ' ') skills"
echo "  • Commands: $(ls -1 "$CLAUDE_DIR/commands/"*.md 2>/dev/null | wc -l | tr -d ' ') commands"
echo "  • Hooks: $(ls -1 "$CLAUDE_DIR/hooks/"*.sh 2>/dev/null | wc -l | tr -d ' ') hooks"
echo ""
echo "📦 Backup saved to: $BACKUP_DIR"
echo ""
echo "⚠️  Note: settings.json was not updated to preserve your customizations."
echo "   Review personal/settings.json for any new hook configurations."
