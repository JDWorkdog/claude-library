#!/bin/bash
# Claude Library - Pre-Write Safety Hook
# Warns before writing to protected or sensitive files

FILE_PATH="$CLAUDE_FILE_PATH"

# Protected file patterns
PROTECTED_PATTERNS=(
    ".env"
    ".env.local"
    ".env.production"
    "credentials"
    "secrets"
    "*.pem"
    "*.key"
    "*.crt"
    "id_rsa"
    "id_ed25519"
)

# Lock files (usually auto-generated, shouldn't be manually edited)
LOCK_FILES=(
    "package-lock.json"
    "yarn.lock"
    "pnpm-lock.yaml"
    "Gemfile.lock"
    "poetry.lock"
    "Cargo.lock"
    "composer.lock"
)

# Check protected patterns
for pattern in "${PROTECTED_PATTERNS[@]}"; do
    if [[ "$FILE_PATH" == *"$pattern"* ]]; then
        echo "⚠️  WARNING: Writing to sensitive file: $FILE_PATH"
        echo "   This file may contain secrets or credentials."
        break
    fi
done

# Check lock files
for lockfile in "${LOCK_FILES[@]}"; do
    if [[ "$FILE_PATH" == *"$lockfile"* ]]; then
        echo "⚠️  WARNING: Writing to lock file: $FILE_PATH"
        echo "   Lock files are usually auto-generated. Manual edits may cause issues."
        break
    fi
done

# Check if writing to system directories
if [[ "$FILE_PATH" == /etc/* ]] || [[ "$FILE_PATH" == /usr/* ]] || [[ "$FILE_PATH" == /var/* ]]; then
    echo "⚠️  WARNING: Writing to system directory: $FILE_PATH"
fi

exit 0
