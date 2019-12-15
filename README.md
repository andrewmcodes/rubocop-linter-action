[version]: <> "v2.0.0"
[release]: https://github.com/andrewmcodes/rubocop-linter-action/releases/latest
[changelog]: /CHANGELOG.md
[image1]: /screenshots/check-overview.png
[image2]: /screenshots/file-annotation.png

![Linters](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Linters/badge.svg)
![Tests](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Test/badge.svg)
![Build](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Build/badge.svg)
![Version Number](https://img.shields.io/static/v1?label=Version&message=v2.0.1&color=blue)
[![Changelog](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Changelog/badge.svg)][changelog]
[![Documentation Status](https://readthedocs.org/projects/rubocop-linter-action/badge/?version=latest)](https://rubocop-linter-action.readthedocs.io/en/latest/?badge=latest)
[![All Contributors](https://img.shields.io/badge/all_contributors-8-orange.svg?style=flat-square)](#contributors)

# Rubocop Linter Action
A GitHub Action to run [Rubocop](https://github.com/rubocop-hq/rubocop) against your codebase and output the results in the [GitHub Checks UI](https://developer.github.com/changes/2018-05-07-new-checks-api-public-beta/).

- [Rubocop Linter Action](#rubocop-linter-action)
  - [Introduction](#introduction)
  - [Usage](#usage)
    - [Quickstart](#quickstart)
    - [Version Contraints](#version-contraints)
    - [Example Workflows](#example-workflows)
  - [:camera_flash: Screenshots](#cameraflash-screenshots)
  - [:bookmark: Changelog](#bookmark-changelog)
  - [:sos: Contributing](#sos-contributing)
  - [:rotating_light: Code of Conduct](#rotatinglight-code-of-conduct)
  - [:copyright: License](#copyright-license)
  - [:1st_place_medal: Recognition](#1stplacemedal-recognition)
  - [:robot: Check Out My Other Ruby GitHub Actions](#robot-check-out-my-other-ruby-github-actions)
  - [✨ Contributors](#%e2%9c%a8-contributors)

## Introduction

GitHub Actions are an amazing new tool that can dramatically improve productivity while using the GitHub platform. While it is not hard to write a custom GitHub action to run Rubocop on your codebase, this action takes that functionality one step further using the checks API. After the Rubocop Linter Action runs Rubocop against your code, it will create annotations that you can easily view, matched up with the offending code.

Since GitHub actions and the checks API are continually changing, it is possible that there will be breaking API changes that affect this action. If so, please open an issue and I will look into it as soon as I can.

## Usage

### Quickstart

Default usage, similar to running `gem install rubocop && rubocop` from your command line:

```yaml
- name: Rubocop Linter Action
  uses: andrewmcodes/rubocop-linter-action@v2.0.1
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Version Contraints

It is **highly** recommended you constrain your action to a specific version.

```yml
# ❌ Danger, sometimes we break things or the GitHub API changes without notice!
uses: andrewmcodes/rubocop-linter-action@master

# ✅ Much better.
uses: andrewmcodes/rubocop-linter-action@v2.0.1
```

### Example Workflows

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
      uses: andrewmcodes/rubocop-linter-action@v2.0.1
      with:
        action_config_path: '.github/config/rubocop_linter_action.yml' # Note: this is the default location
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## :camera_flash: Screenshots

![Rubocop Linter Checks Overview][image1]
![Rubocop Linter File Annotation][image2]

## :bookmark: Changelog

[View our Changelog](/CHANGELOG.md)

## :sos: Contributing

[Contributing Guide](/CONTRIBUTING.md)

## :rotating_light: Code of Conduct

[Code of Conduct](/CODE_OF_CONDUCT.md)

## :copyright: License

[MIT](/LICENSE.md)

## :1st_place_medal: Recognition

This project was originally forked from [gimenete/rubocop-action](https://github.com/gimenete/rubocop-action). Many thanks to [Alberto Gimeno](https://github.com/gimenete) for creating this project.

## :robot: Check Out My Other Ruby GitHub Actions

- [andrewmcodes/haml-lint-action](https://github.com/andrewmcodes/haml-lint-action).
- [andrewmcodes/standardrb-action](https://github.com/andrewmcodes/standardrb-action).

## ✨ Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://www.andrewmason.me/"><img src="https://avatars1.githubusercontent.com/u/18423853?v=4" width="100px;" alt=""/><br /><sub><b>Andrew Mason</b></sub></a><br /><a href="#infra-andrewmcodes" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/pulls?q=is%3Apr+reviewed-by%3Aandrewmcodes" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=andrewmcodes" title="Documentation">📖</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=andrewmcodes" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/MiguelSavignano"><img src="https://avatars3.githubusercontent.com/u/6641863?v=4" width="100px;" alt=""/><br /><sub><b>Miguel Savignano</b></sub></a><br /><a href="#infra-MiguelSavignano" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=MiguelSavignano" title="Tests">⚠️</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=MiguelSavignano" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/mcgregordan"><img src="https://avatars0.githubusercontent.com/u/17787076?v=4" width="100px;" alt=""/><br /><sub><b>Dan McGregor</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=mcgregordan" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/amerritt14"><img src="https://avatars3.githubusercontent.com/u/16766681?v=4" width="100px;" alt=""/><br /><sub><b>amerritt14</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=amerritt14" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/bbugh"><img src="https://avatars3.githubusercontent.com/u/438465?v=4" width="100px;" alt=""/><br /><sub><b>Brian Bugh</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=bbugh" title="Code">💻</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=bbugh" title="Tests">⚠️</a></td>
    <td align="center"><a href="http://reidbeels.com"><img src="https://avatars2.githubusercontent.com/u/13192?v=4" width="100px;" alt=""/><br /><sub><b>Reid Beels</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=reidab" title="Code">💻</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=reidab" title="Tests">⚠️</a></td>
    <td align="center"><a href="http://www.chris-pezza.com"><img src="https://avatars3.githubusercontent.com/u/5841177?v=4" width="100px;" alt=""/><br /><sub><b>Christopher Pezza</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=chiefpansancolt" title="Code">💻</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=chiefpansancolt" title="Documentation">📖</a> <a href="#infra-chiefpansancolt" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/InteNs"><img src="https://avatars1.githubusercontent.com/u/6474105?v=4" width="100px;" alt=""/><br /><sub><b>Mark Havekes</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/issues?q=author%3AInteNs" title="Bug reports">🐛</a></td>
    <td align="center"><a href="http://www.hackerdude.com"><img src="https://avatars3.githubusercontent.com/u/30315?v=4" width="100px;" alt=""/><br /><sub><b>David Martinez</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=hackerdude" title="Code">💻</a></td>
    <td align="center"><a href="http://gorails.com"><img src="https://avatars1.githubusercontent.com/u/67093?v=4" width="100px;" alt=""/><br /><sub><b>Chris Oliver</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/pulls?q=is%3Apr+reviewed-by%3Aexcid3" title="Reviewed Pull Requests">👀</a> <a href="#ideas-excid3" title="Ideas, Planning, & Feedback">🤔</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
