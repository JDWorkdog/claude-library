# Contributing to Claude Library

Thank you for your interest in contributing to the Claude Library! This guide explains how to add or modify components.

## Component Standards

### Required Structure

Every component must include:

1. **YAML Frontmatter** (for agents, skills, commands)
   ```yaml
   ---
   name: component-name
   description: Brief description of what this component does
   version: 1.0.0
   author: Your Name
   ---
   ```

2. **When to Use** section - Clear guidance on when to use this component

3. **Example Usage** - At least one practical example

4. **Configuration Options** (if applicable)

### Naming Conventions

- **Agents**: Function-first naming (e.g., `code-reviewer`, `test-engineer`)
- **Commands**: Lowercase, hyphenated (e.g., `review`, `daily-plan`)
- **Skills**: Hyphenated folders (e.g., `code-review/`, `test-generation/`)
- **Hooks**: Descriptive with `.sh` extension (e.g., `pre-bash-safety.sh`)

## Adding a New Component

### Agents

1. Create a new `.md` file in `personal/agents/`
2. Include YAML frontmatter with name, description, version
3. Add documentation in `docs/agents/<agent-name>.md`
4. Update `docs/agents/README.md` with the new agent

### Skills

1. Create a new folder in `personal/skills/<skill-name>/`
2. Add `SKILL.md` with the skill definition
3. Include any supporting files (templates, scripts)
4. Add documentation in `docs/skills/<skill-name>.md`
5. Update `docs/skills/README.md`

### Commands

1. Create a new `.md` file in `personal/commands/`
2. Include YAML frontmatter
3. Add documentation in `docs/commands/<command-name>.md`
4. Update `docs/commands/README.md`

### Hooks

1. Create a new `.sh` file in `personal/hooks/`
2. Make it executable (`chmod +x`)
3. Add documentation in `docs/hooks/<hook-name>.md`
4. Update `docs/hooks/README.md`
5. Update `personal/settings.json` if it should be auto-enabled

## Testing Your Changes

Before submitting:

1. Test the component in a real project
2. Verify it works with both symlink and copy installation
3. Check documentation renders correctly
4. Ensure no project-specific references remain (generalize!)

## Pull Request Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/new-agent-name`)
3. Make your changes
4. Update CHANGELOG.md
5. Submit a PR with:
   - Clear description of what the component does
   - Why it's useful for the library
   - Any testing you've done

## Versioning

We use [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes to component interfaces
- **MINOR**: New components or backward-compatible features
- **PATCH**: Bug fixes and documentation updates

## Code of Conduct

- Be respectful and constructive
- Focus on improving the library for everyone
- Document your decisions and reasoning

## Questions?

Open an issue with the `question` label if you need help or clarification.
