![rubocop linter actions banner](screenshots/rubocop-linter-action.png)

# Rubocop Linter Action

![version number](https://img.shields.io/static/v1?label=Version&message=v0.1.2&color=blue)

GitHub Action to run Rubocop against your code.

## Usage

Add the following to your GitHub action workflow:

```yaml
- name: Rubocop Linter
  uses: andrewmcodes/rubocop-linter-action@v0.1.2
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Example Workflow

```yaml
name: Ruby

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v1
    - name: Set up Ruby 2.6
      uses: actions/setup-ruby@v1
      with:
        ruby-version: 2.6.x
    - name: add PostgreSQL dependencies
      run: |
        sudo apt-get update
        sudo apt-get install -y postgresql-client libpq-dev
    - name: Rubocop Linter
      uses: andrewmcodes/rubocop-linter-action@v0.1.2
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
