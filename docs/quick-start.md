# Quick Start

Default usage, similar to running `gem install rubocop && rubocop` from your command line:

```yaml
- name: Rubocop Linter Action
  uses: andrewmcodes/rubocop-linter-action@v3.0.0.rc2
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
