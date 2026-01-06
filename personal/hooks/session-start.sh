#!/bin/bash
# Claude Library - Session Start Hook
# Validates common development environment at session start

echo "🔍 Checking environment..."

# Git check
if ! command -v git &> /dev/null; then
    echo "⚠️  WARNING: git not found"
else
    echo "✅ Git $(git --version | cut -d' ' -f3)"
fi

# Node check
if command -v node &> /dev/null; then
    echo "✅ Node $(node --version)"
else
    echo "ℹ️  Node.js not found (optional)"
fi

# Python check
if command -v python3 &> /dev/null; then
    echo "✅ Python $(python3 --version | cut -d' ' -f2)"
else
    echo "ℹ️  Python not found (optional)"
fi

# Check for common env vars
if [ -z "$ANTHROPIC_API_KEY" ] && [ ! -f ".env" ]; then
    echo "ℹ️  No ANTHROPIC_API_KEY or .env file found"
fi

echo "✅ Session started"
