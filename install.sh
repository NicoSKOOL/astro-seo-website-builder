#!/bin/bash
# ============================================================
# Astro SEO Website Builder — Claude Code Plugin Installer
# ============================================================
# Installs the website-builder plugin to ~/.claude/plugins/
# After install, restart Claude Code and run /build-website
# in any project folder.
#
# Usage:
#   bash install.sh
# Or one-line install:
#   curl -sL https://raw.githubusercontent.com/YOUR_USERNAME/astro-seo-website-builder/main/install.sh | bash
# ============================================================

set -e

PLUGIN_DIR="$HOME/.claude/plugins/website-builder"
REPO="https://raw.githubusercontent.com/NicoSKOOL/astro-seo-website-builder/main"

echo ""
echo "================================================="
echo "  Astro SEO Website Builder Plugin Installer"
echo "================================================="
echo ""

# Create directories
echo "Creating plugin directories..."
mkdir -p "$PLUGIN_DIR/commands"
mkdir -p "$PLUGIN_DIR/agents"

# Check if curl is available
if ! command -v curl &> /dev/null; then
  echo "Error: curl is required but not installed. Please install curl and try again."
  exit 1
fi

# Download plugin files
echo "Downloading plugin files..."

curl -sL "$REPO/plugin.json" -o "$PLUGIN_DIR/plugin.json"
echo "  plugin.json"

curl -sL "$REPO/commands/build-website.md" -o "$PLUGIN_DIR/commands/build-website.md"
echo "  commands/build-website.md"

curl -sL "$REPO/agents/seo-writer.md" -o "$PLUGIN_DIR/agents/seo-writer.md"
echo "  agents/seo-writer.md"

curl -sL "$REPO/agents/seo-auditor.md" -o "$PLUGIN_DIR/agents/seo-auditor.md"
echo "  agents/seo-auditor.md"

curl -sL "$REPO/agents/tech-builder.md" -o "$PLUGIN_DIR/agents/tech-builder.md"
echo "  agents/tech-builder.md"

echo ""
echo "================================================="
echo "  Installation complete!"
echo "================================================="
echo ""
echo "Plugin installed to: $PLUGIN_DIR"
echo ""
echo "Next steps:"
echo "  1. Restart Claude Code"
echo "  2. Create or navigate to your project folder"
echo "  3. Run: /build-website"
echo ""
echo "Prerequisites (if not already set up):"
echo "  - Node.js 18+ installed"
echo "  - A Cloudflare account (free tier works)"
echo "  - A Resend account for contact form email delivery"
echo "  - The nano-banana-pro skill installed in Claude Code"
echo ""
