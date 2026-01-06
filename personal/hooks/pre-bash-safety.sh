#!/bin/bash
# Claude Library - Pre-Bash Safety Hook
# Warns before executing dangerous bash commands

COMMAND="$CLAUDE_TOOL_INPUT"

# BLOCK: Catastrophic commands
if [[ "$COMMAND" =~ "rm -rf /" ]] || [[ "$COMMAND" =~ "rm -rf ~" ]] || [[ "$COMMAND" =~ "rm -rf $HOME" ]]; then
    echo "🛑 BLOCKED: Refusing to delete root or home directory"
    exit 1
fi

# WARN: Force push
if [[ "$COMMAND" =~ "git push --force" ]] || [[ "$COMMAND" =~ "git push -f" ]]; then
    echo "⚠️  WARNING: Force push detected. This can overwrite remote history."
fi

# WARN: Force push to main/master
if [[ "$COMMAND" =~ "git push".*"--force".*"main" ]] || [[ "$COMMAND" =~ "git push".*"--force".*"master" ]]; then
    echo "🛑 WARNING: Force push to main/master branch detected!"
fi

# WARN: Database destructive operations
if [[ "$COMMAND" =~ "DROP TABLE" ]] || [[ "$COMMAND" =~ "drop table" ]]; then
    echo "⚠️  WARNING: DROP TABLE detected. Are you sure?"
fi

if [[ "$COMMAND" =~ "DROP DATABASE" ]] || [[ "$COMMAND" =~ "drop database" ]]; then
    echo "⚠️  WARNING: DROP DATABASE detected. This is destructive!"
fi

if [[ "$COMMAND" =~ "TRUNCATE" ]] || [[ "$COMMAND" =~ "truncate" ]]; then
    echo "⚠️  WARNING: TRUNCATE detected. This removes all data from the table."
fi

# WARN: npm publish
if [[ "$COMMAND" =~ "npm publish" ]]; then
    echo "⚠️  WARNING: Publishing to npm. Verify package.json version first."
fi

# WARN: Docker system prune
if [[ "$COMMAND" =~ "docker system prune" ]]; then
    echo "⚠️  WARNING: Docker system prune will remove unused data."
fi

# WARN: chmod/chown recursive on system paths
if [[ "$COMMAND" =~ "chmod -R".*"/" ]] || [[ "$COMMAND" =~ "chown -R".*"/" ]]; then
    echo "⚠️  WARNING: Recursive permission change detected. Verify the path."
fi

exit 0
