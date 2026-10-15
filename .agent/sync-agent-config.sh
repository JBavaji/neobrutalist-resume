#!/usr/bin/env bash
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "Synchronizing multi-agent configuration links..."

mkdir -p .github

# Symlink AGENT.md to provider-specific configuration files
ln -sf AGENT.md CLAUDE.md
ln -sf AGENT.md GEMINI.md
ln -sf AGENT.md .cursorrules
ln -sf AGENT.md .windsurfrules
ln -sf ../AGENT.md .github/copilot-instructions.md

echo "✓ Provider configurations synchronized:"
echo "  - CLAUDE.md -> AGENT.md"
echo "  - GEMINI.md -> AGENT.md"
echo "  - .cursorrules -> AGENT.md"
echo "  - .windsurfrules -> AGENT.md"
echo "  - .github/copilot-instructions.md -> AGENT.md"
