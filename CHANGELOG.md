# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial library structure
- 20 agents across 5 categories (development, database, productivity, analysis, documentation)
- 3 safety hooks (session-start, pre-bash-safety, pre-write-safety)
- 5 skills (code-review, test-generation, security-audit, code-explanation, pr-creation)
- 9 commands (review, test, security, commit, explain, onboard, daily, research, prd)
- 4 GitHub Actions workflow templates
- 3 project templates (nextjs-trpc, python-notebook, data-analysis)
- Installation scripts (symlink and copy options)
- Comprehensive documentation

## [1.0.0] - 2025-01-06

### Added
- Initial release of Claude Library
- Personal components for `~/.claude/` installation
- Project templates for quick project setup
- GitHub Actions for CI/CD automation
- Installation and update scripts

### Sources
Components consolidated from:
- claude-dev-environment (engineering agents, skills)
- Workdog-DesktopAI (productivity agents)
- daily-grind (productivity agents)
- adhoc_agent_to_slides (analysis patterns)

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2025-01-06 | Initial release |
