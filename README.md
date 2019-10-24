![rubocop linter actions banner](screenshots/rubocop-linter-action.png)

# Rubocop Linter Action

![version number](https://img.shields.io/static/v1?label=Version&message=v0.2.0&color=blue)

GitHub Action to run Rubocop against your code and create annotations in the UI.

**NOTE: due to the GitHub Check Runs API, we can only return 50 annotations per run. See [here](https://developer.github.com/v3/checks/runs/#output-object) for more info.**

## Usage

Add the following to your GitHub action workflow:

```yaml
- name: Rubocop Linter
  uses: andrewmcodes/rubocop-linter-action@v0.2.0
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Example Workflow

```yaml
name: Rubocop

on:
  pull_request:
    branches:
      - '*'
  push:
    branches:
      - master

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Rubocop Linter
      uses: andrewmcodes/rubocop-linter-action@v0.2.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Screenshots

![example GitHub Action UI](screenshots/ui-example.png)

## Contributing

[Contributing Guide](/CONTRIBUTING.md)

## Code of Conduct

[Code of Conduct](/CODE_OF_CONDUCT.md)

## License

[MIT](/LICENSE.md)

## Recognition

This project was originally forked from [gimenete/rubocop-action](https://github.com/gimenete/rubocop-action). Many thanks to [Alberto Gimeno](https://github.com/gimenete) for creating this project.
