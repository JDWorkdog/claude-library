#!/bin/bash
# Claude Library - Project Initialization Script
# Creates a new project with Claude configuration from a template

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIBRARY_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATES_DIR="$LIBRARY_DIR/project/templates"

# Usage function
usage() {
    echo "Usage: $0 <template> <project-directory>"
    echo ""
    echo "Available templates:"
    for template in "$TEMPLATES_DIR"/*/; do
        if [ -d "$template" ]; then
            local name=$(basename "$template")
            echo "  • $name"
        fi
    done
    echo ""
    echo "Example:"
    echo "  $0 nextjs-trpc my-new-project"
    exit 1
}

# Check arguments
if [ $# -lt 2 ]; then
    usage
fi

TEMPLATE=$1
PROJECT_DIR=$2
TEMPLATE_PATH="$TEMPLATES_DIR/$TEMPLATE"

echo "╔════════════════════════════════════════════╗"
echo "║  Claude Library - Project Initialization   ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# Check template exists
if [ ! -d "$TEMPLATE_PATH" ]; then
    echo "❌ Template '$TEMPLATE' not found."
    echo ""
    echo "Available templates:"
    for template in "$TEMPLATES_DIR"/*/; do
        if [ -d "$template" ]; then
            echo "  • $(basename "$template")"
        fi
    done
    exit 1
fi

# Check if project directory already exists
if [ -d "$PROJECT_DIR" ]; then
    echo "⚠️  Directory '$PROJECT_DIR' already exists."
    read -p "Do you want to add .claude/ configuration to it? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        exit 0
    fi
else
    echo "📁 Creating project directory: $PROJECT_DIR"
    mkdir -p "$PROJECT_DIR"
fi

# Copy template contents
echo "📋 Copying template: $TEMPLATE"
echo ""

# Copy .claude/ directory
if [ -d "$TEMPLATE_PATH/.claude" ]; then
    cp -r "$TEMPLATE_PATH/.claude" "$PROJECT_DIR/.claude"
    echo "   ✅ Copied .claude/"
fi

# Copy .github/ directory if exists
if [ -d "$TEMPLATE_PATH/.github" ]; then
    cp -r "$TEMPLATE_PATH/.github" "$PROJECT_DIR/.github"
    echo "   ✅ Copied .github/"
fi

# Copy README if exists and project doesn't have one
if [ -f "$TEMPLATE_PATH/README.md" ] && [ ! -f "$PROJECT_DIR/README.md" ]; then
    cp "$TEMPLATE_PATH/README.md" "$PROJECT_DIR/README.md"
    echo "   ✅ Copied README.md"
fi

# Replace placeholders in files
echo ""
echo "⚙️  Customizing for project..."

PROJECT_NAME=$(basename "$PROJECT_DIR")

# Replace PROJECT_NAME placeholder in CLAUDE.md
if [ -f "$PROJECT_DIR/.claude/CLAUDE.md" ]; then
    sed -i.bak "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$PROJECT_DIR/.claude/CLAUDE.md"
    rm -f "$PROJECT_DIR/.claude/CLAUDE.md.bak"
    echo "   ✅ Updated CLAUDE.md with project name"
fi

# Summary
echo ""
echo "╔════════════════════════════════════════════╗"
echo "║  Project Initialized!                      ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "Project: $PROJECT_DIR"
echo "Template: $TEMPLATE"
echo ""
echo "Created files:"
find "$PROJECT_DIR" -type f -name "*.md" -o -name "*.json" -o -name "*.yml" 2>/dev/null | sed 's/^/  • /'
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_DIR"
echo "  2. Review .claude/CLAUDE.md and customize for your project"
echo "  3. Review .claude/settings.json for project-specific settings"
if [ -d "$PROJECT_DIR/.github" ]; then
    echo "  4. Review .github/workflows/ for CI/CD configuration"
fi
