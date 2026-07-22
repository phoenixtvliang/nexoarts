#!/bin/bash
# Auto-sync script: merges main into gh-pages
# Usage: ./scripts/auto-sync.sh
# Run this after pushing to main, OR set up a cron/CI to run it

set -e

echo "🔄 Syncing main → gh-pages for GitHub Pages deployment..."

git fetch origin
git checkout gh-pages
git merge origin/main --no-edit --allow-unrelated-histories || true

# Resolve conflicts by taking main's version
git checkout --theirs . 2>/dev/null || true
git add -A

# Check if there are actual changes
if git diff --cached --quiet; then
    echo "✅ gh-pages is already up to date"
else
    git commit -m "chore: sync from main [auto-sync]"
    git push origin gh-pages
    echo "✅ Pushed to gh-pages. GitHub Pages will rebuild in ~1-2 minutes."
    echo "🌐 Your site will be live at: https://nexoarts.com/"
fi

git checkout main
