#!/usr/bin/env bash
# ==============================================================================
# token-audit.sh
# Deterministic CI/Local linter to detect raw CSS values and enforce tokens.css.
# Flags: hardcoded hex colors, raw pixel paddings/margins, and raw border radii.
# Returns exit code 1 if violations are found.
# ==============================================================================

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TARGET_DIR="${1:-$ROOT_DIR}"

echo "=========================================================="
echo "🔍 Scanning for Hardcoded Visual CSS Values"
echo "=========================================================="

VIOLATIONS=0

# Pattern 1: Hardcoded Hex Colors (#...)
echo "Checking for hardcoded hex colors..."
HEX_MATCHES=$(grep -rnE '(#[0-9a-fA-F]{3,8})' "$TARGET_DIR" \
  --exclude-dir={.git,.agent,node_modules,build,dist,reference} \
  --exclude={"tokens.css","tokens.template.css","*.md","*.json","*.html"} \
  --include={"*.css","*.scss","*.tsx","*.jsx"} || true)

if [[ -n "$HEX_MATCHES" ]]; then
  echo "❌ Found hardcoded hex colors (use var(--color-...) instead):"
  echo "$HEX_MATCHES"
  VIOLATIONS=$((VIOLATIONS + 1))
fi

# Pattern 2: Raw pixel spacing in padding or margin (e.g., padding: 12px, margin: 15px)
echo "Checking for raw pixel padding/margin..."
PIXEL_MATCHES=$(grep -rnE '(padding|margin|gap):\s*[0-9]+px' "$TARGET_DIR" \
  --exclude-dir={.git,.agent,node_modules,build,dist} \
  --exclude={"tokens.css","tokens.template.css","*.md","*.json"} \
  --include={"*.css","*.scss","*.tsx","*.jsx"} || true)

if [[ -n "$PIXEL_MATCHES" ]]; then
  echo "❌ Found raw pixel spacing (use var(--space-...) instead):"
  echo "$PIXEL_MATCHES"
  VIOLATIONS=$((VIOLATIONS + 1))
fi

# Pattern 3: Raw pixel border-radius
echo "Checking for raw border-radius..."
RADIUS_MATCHES=$(grep -rnE 'border-radius:\s*[0-9]+px' "$TARGET_DIR" \
  --exclude-dir={.git,.agent,node_modules,build,dist} \
  --exclude={"tokens.css","tokens.template.css","*.md","*.json"} \
  --include={"*.css","*.scss","*.tsx","*.jsx"} || true)

if [[ -n "$RADIUS_MATCHES" ]]; then
  echo "❌ Found raw border-radius (use var(--radius-...) instead):"
  echo "$RADIUS_MATCHES"
  VIOLATIONS=$((VIOLATIONS + 1))
fi

echo "----------------------------------------------------------"
if [[ $VIOLATIONS -gt 0 ]]; then
  echo "❌ TOKEN AUDIT FAILED: $VIOLATIONS violation category/categories found."
  echo "Replace raw visual values with semantic tokens from tokens.css."
  exit 1
else
  echo "✅ TOKEN AUDIT PASSED: Zero hardcoded visual values detected."
  exit 0
fi
