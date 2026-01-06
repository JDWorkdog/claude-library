#!/bin/bash
# Claude Library - Component Diff Script
# Compares similar components across multiple projects to find the best version

set -e

# Projects to scan
PROJECTS=(
    "/Users/johnworkman/Documents/Projects/claude-dev-environment/.claude"
    "/Users/johnworkman/Documents/Projects/Workdog-DesktopAI/.claude"
    "/Users/johnworkman/Documents/Projects/daily-grind/.claude"
    "/Users/johnworkman/Documents/Projects/adhoc_agent_to_slides/.claude"
    "/Users/johnworkman/Documents/Projects/pr-134-worktree/.claude"
    "/Users/johnworkman/Documents/Projects/dtools-insight-max-quote-share/.claude"
)

echo "╔════════════════════════════════════════════╗"
echo "║  Claude Library - Component Diff           ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# Function to compare a specific component
compare_component() {
    local name=$1
    local type=$2  # agents, commands, skills

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📄 $name ($type)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    local found=0

    for project in "${PROJECTS[@]}"; do
        local file="$project/$type/$name.md"
        if [ -f "$file" ]; then
            found=$((found + 1))
            local project_name=$(basename "$(dirname "$project")")
            local lines=$(wc -l < "$file" | tr -d ' ')
            local size=$(du -h "$file" | cut -f1)

            echo ""
            echo "📁 $project_name"
            echo "   Path: $file"
            echo "   Lines: $lines"
            echo "   Size: $size"

            # Show description from frontmatter
            if grep -q "^description:" "$file"; then
                echo "   Description: $(grep "^description:" "$file" | head -1 | sed 's/description: //')"
            fi

            # Show first few content lines (skip frontmatter)
            echo "   Preview:"
            sed -n '/^---$/,/^---$/d; 1,5p' "$file" 2>/dev/null | sed 's/^/      /'
        fi
    done

    if [ $found -eq 0 ]; then
        echo "   ❌ Not found in any project"
    elif [ $found -eq 1 ]; then
        echo ""
        echo "   ✅ Only one version found - no comparison needed"
    else
        echo ""
        echo "   ⚠️  Found $found versions - comparison needed"
    fi

    echo ""
}

# Function to list all components of a type
list_all_components() {
    local type=$1  # agents, commands, skills

    echo ""
    echo "╔════════════════════════════════════════════╗"
    echo "║  All $type across projects                 ║"
    echo "╚════════════════════════════════════════════╝"
    echo ""

    for project in "${PROJECTS[@]}"; do
        local dir="$project/$type"
        if [ -d "$dir" ]; then
            local project_name=$(basename "$(dirname "$project")")
            local count=$(ls -1 "$dir"/*.md 2>/dev/null | wc -l | tr -d ' ')

            if [ "$count" -gt 0 ]; then
                echo "📁 $project_name ($count $type)"
                ls -1 "$dir"/*.md 2>/dev/null | xargs -I {} basename {} .md | sed 's/^/   • /'
                echo ""
            fi
        fi
    done
}

# Main menu
echo "Choose what to compare:"
echo ""
echo "1. Compare specific component"
echo "2. List all agents"
echo "3. List all commands"
echo "4. List all skills"
echo "5. Compare known duplicates"
echo "6. Full report"
echo ""
read -p "Enter choice (1-6): " choice
echo ""

case $choice in
    1)
        read -p "Component name (without .md): " name
        read -p "Type (agents/commands/skills): " type
        compare_component "$name" "$type"
        ;;
    2)
        list_all_components "agents"
        ;;
    3)
        list_all_components "commands"
        ;;
    4)
        list_all_components "skills"
        ;;
    5)
        echo "Comparing known duplicates..."
        echo ""

        # Daily planning related
        compare_component "daily-planning-agent" "agents"
        compare_component "context-builder" "agents"
        compare_component "task-decomposer" "agents"

        # Research related
        compare_component "research-agent" "agents"
        compare_component "research" "agents"

        # Review commands
        compare_component "review" "commands"

        # Daily commands
        compare_component "daily" "commands"
        ;;
    6)
        echo "Generating full report..."
        echo ""
        list_all_components "agents"
        list_all_components "commands"
        list_all_components "skills"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Done!"
