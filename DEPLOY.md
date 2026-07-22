# NEXO Arts Website

Connecting China and Latin America through Culture.

## 🚀 Deploy

This site uses GitHub Pages deployed from the `gh-pages` branch.

### Quick Deploy (after editing files)

```bash
# 1. Make your changes on main
git add -A
git commit -m "your change"
git push origin main

# 2. Sync to gh-pages (auto-deploy)
./scripts/auto-sync.sh
```

Or manually:
```bash
git checkout gh-pages
git merge origin/main
git push origin gh-pages
git checkout main
```

### Auto-sync (recommended)

For fully automatic sync, you need a GitHub Actions workflow file.
Due to PAT token limitations, the workflow file was not pushed automatically.

**To set up auto-sync:**

1. Go to: https://github.com/phoenixtvliang/nexoarts/settings/pages
2. Under "Source", select **"Deploy from a branch"** → branch: **gh-pages**, folder: **/ (root)**
3. That's it — GitHub Pages will rebuild automatically when `gh-pages` is updated

**To enable full automation, add a GitHub Action:**

1. Go to: https://github.com/phoenixtvliang/nexoarts/actions/new
2. Choose "Basic workflow" or paste this YAML into `.github/workflows/sync-gh-pages.yml` on the `gh-pages` branch:

```yaml
name: Sync gh-pages
on:
  push:
    branches: [main]
jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
          ref: main
      - run: |
          git config user.name "github-actions"
          git config user.email "actions@github.com"
          git fetch origin gh-pages
          git checkout gh-pages
          git merge origin/main --no-edit || true
          git checkout --theirs . 2>/dev/null || true
          git add -A
          git commit -m "chore: sync from main" --allow-empty || true
          git push origin gh-pages
```

> ⚠️ You need a GitHub token with `workflow` scope (not the current PAT).
> Go to https://github.com/settings/tokens and generate a new token with `workflow` permission.
