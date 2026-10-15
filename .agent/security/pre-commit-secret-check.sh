# Pre-Commit Secret Scanner
# Ensures no credentials, .env files, or API keys are committed locally

set -euo pipefail

# Check for staged .env or credential files
STAGED_SECRETS=$(git diff --cached --name-only | grep -E '(\.env|\.pem|\.key|id_rsa|credentials\.json)$' || true)

if [ -n "$STAGED_SECRETS" ]; then
  echo "❌ CRITICAL SECURITY ERROR: Staged files contain potential credentials:" >&2
  echo "$STAGED_SECRETS" >&2
  echo "Remove these files before committing." >&2
  exit 1
fi

exit 0
