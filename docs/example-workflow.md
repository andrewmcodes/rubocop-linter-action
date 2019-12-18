### Example Workflow

Here is an example workflow file incorporating Rubocop Linter Action:

```yaml
name: Rubocop

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Rubocop Linter
      uses: andrewmcodes/rubocop-linter-action@v2.0.0
      with:
        additional_gems: 'rubocop-rails rubocop-performance'
        fail_level: 'warning'
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Go [here](https://github.com/andrewmcodes/rubocop-linter-action-playground/blob/master/.github/workflows/test.yml) to see more examples!**
