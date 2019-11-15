![Rubocop](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Rubocop/badge.svg)
![Tests](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Test/badge.svg)
![Build](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Build/badge.svg)
[![Changelog](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Changelog/badge.svg)](/CHANGELOG.md)
![Version Number](https://img.shields.io/static/v1?label=Version&message=v1.0.4&color=blue)
[![All Contributors](https://img.shields.io/badge/all_contributors-5-orange.svg?style=flat-square)](#contributors)

# :white_check_mark: Rubocop Linter Action

A GitHub Action to run [Rubocop](https://github.com/rubocop-hq/rubocop) against your code and create annotations in the GitHub UI.

- [:white_check_mark: Rubocop Linter Action](#whitecheckmark-rubocop-linter-action)
  - [:page_facing_up: Introduction](#pagefacingup-introduction)
  - [:bulb: Usage](#bulb-usage)
    - [:package: Example Workflow](#package-example-workflow)
  - [:warning: Gotchas](#warning-gotchas)
  - [:camera_flash: Screenshots](#cameraflash-screenshots)
  - [:bookmark: Changelog](#bookmark-changelog)
  - [:sos: Contributing](#sos-contributing)
  - [:rotating_light: Code of Conduct](#rotatinglight-code-of-conduct)
  - [:copyright: License](#copyright-license)
  - [:1st_place_medal: Recognition](#1stplacemedal-recognition)
  - [:robot: Check Out My Other Ruby GitHub Actions](#robot-check-out-my-other-ruby-github-actions)
  - [✨ Contributors](#%e2%9c%a8-contributors)

## :page_facing_up: Introduction

GitHub Actions are an amazing new tool that can dramatically improve productivity while using the GitHub platform. While it is not hard to write a custom GitHub action to run Rubocop on your codebase, this action takes that functionality one step further using the checks API. After the Rubocop Linter Action runs Rubocop against your code, it will create annotations that you can easily view, matched up with the offending code.

Since GitHub actions and the checks API are continually changing, it is possible that there will be breaking API changes that affect this action. If so, please open an issue and I will look into it as soon as I can.

## :bulb: Usage

Add the following to your GitHub action workflow to use Rubocop Linter Action:

```yaml
- name: Rubocop Linter
  uses: andrewmcodes/rubocop-linter-action@v1.0.4
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### :package: Example Workflow

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
      uses: andrewmcodes/rubocop-linter-action@v1.0.4
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## :warning: Gotchas

Due to the GitHub Check Runs API, we can only return 50 annotations per run. See [here](https://developer.github.com/v3/checks/runs/#output-object) for more info.

## :camera_flash: Screenshots

![Rubocop Linter Checks Overview](screenshots/check-overview.png)
![Rubocop Linter File Annotation](screenshots/file-annotation.png)

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
<!-- prettier-ignore -->
<table>
  <tr>
    <td align="center"><a href="https://www.andrewmason.me/"><img src="https://avatars1.githubusercontent.com/u/18423853?v=4" width="100px;" alt="Andrew Mason"/><br /><sub><b>Andrew Mason</b></sub></a><br /><a href="#infra-andrewmcodes" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="#review-andrewmcodes" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=andrewmcodes" title="Documentation">📖</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=andrewmcodes" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/MiguelSavignano"><img src="https://avatars3.githubusercontent.com/u/6641863?v=4" width="100px;" alt="Miguel Savignano"/><br /><sub><b>Miguel Savignano</b></sub></a><br /><a href="#infra-MiguelSavignano" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=MiguelSavignano" title="Tests">⚠️</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=MiguelSavignano" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/mcgregordan"><img src="https://avatars0.githubusercontent.com/u/17787076?v=4" width="100px;" alt="Dan McGregor"/><br /><sub><b>Dan McGregor</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=mcgregordan" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/amerritt14"><img src="https://avatars3.githubusercontent.com/u/16766681?v=4" width="100px;" alt="amerritt14"/><br /><sub><b>amerritt14</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=amerritt14" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/bbugh"><img src="https://avatars3.githubusercontent.com/u/438465?v=4" width="100px;" alt="Brian Bugh"/><br /><sub><b>Brian Bugh</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=bbugh" title="Code">💻</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=bbugh" title="Tests">⚠️</a></td>
    <td align="center"><a href="http://reidbeels.com"><img src="https://avatars2.githubusercontent.com/u/13192?v=4" width="100px;" alt="Reid Beels"/><br /><sub><b>Reid Beels</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=reidab" title="Code">💻</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=reidab" title="Tests">⚠️</a></td>
  </tr>
</table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
