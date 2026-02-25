#!/bin/bash
# ============================================================
# Astro SEO Website Builder - Claude Code Plugin Installer
# ============================================================
# Adds this repo as a Claude Code marketplace and installs
# the website-builder plugin.
#
# Usage:
#   bash install.sh
# Or one-line install:
#   curl -sL https://raw.githubusercontent.com/NicoSKOOL/astro-seo-website-builder/main/install.sh | bash
# ============================================================

set -e

MARKETPLACE_NAME="astro-seo-website-builder"
GITHUB_REPO="NicoSKOOL/astro-seo-website-builder"

echo ""
echo "================================================="
echo "  Astro SEO Website Builder Plugin Installer"
echo "================================================="
echo ""

# Check if claude CLI is available
if ! command -v claude &> /dev/null; then
  echo "Error: Claude Code CLI is required but not found."
  echo "Install it from: https://claude.ai/code"
  exit 1
fi

# Add this repo as a marketplace
echo "Adding marketplace..."
claude plugin marketplace add "$GITHUB_REPO" 2>/dev/null || true

# Install the plugin
echo "Installing website-builder plugin..."
claude plugin install "website-builder@${MARKETPLACE_NAME}"

echo ""
echo "================================================="
echo "  Installation complete!"
echo "================================================="
echo ""
echo "Next steps:"
echo "  1. Restart Claude Code"
echo "  2. Create or navigate to your project folder"
echo "  3. Run: /website-builder:build-website"
echo ""
echo "Prerequisites (if not already set up):"
echo "  - Node.js 18+ installed"
echo "  - A Cloudflare account (free tier works)"
echo "  - A Resend account for contact form email delivery"
echo "  - The nano-banana-pro skill installed in Claude Code"
echo ""
