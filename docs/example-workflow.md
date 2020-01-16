# Example Workflow

Here is an example workflow file incorporating Rubocop Linter Action with customized usage based on the values in your configuration file:

```yaml
name: Linters

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Rubocop Linter
      uses: andrewmcodes/rubocop-linter-action@v3.0.0.rc4
      with:
        action_config_path: '.github/config/rubocop_linter_action.yml' # Note: this is the default location
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Go [here](https://github.com/andrewmcodes/rubocop-linter-action-playground/blob/master/.github/workflows) to see more examples!**
