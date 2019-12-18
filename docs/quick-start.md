# Quick Start

Add the following to your GitHub action workflow to use Rubocop Linter Action:

```yaml
- name: Rubocop Linter
  uses: andrewmcodes/rubocop-linter-action@v2.0.0
  with:
    additional_gems: 'rubocop-rails rubocop-performance'
    fail_level: 'warning'
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

# Version Constraints

It is **highly** recommend you tie yourself to a version and do not do the following. I promise your life will be much easier. 😇

```yml
# ❌ Danger, sometimes I break things!
uses: andrewmcodes/rubocop-linter-action@master

# ✅ Much better.
uses: andrewmcodes/rubocop-linter-action@v2.0.0
```
