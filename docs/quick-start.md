# Quick Start

Default usage, similar to running `gem install rubocop && rubocop` from your command line:

```yaml
- name: Rubocop Linter Action
  uses: andrewmcodes/rubocop-linter-action@v2.0.1
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
