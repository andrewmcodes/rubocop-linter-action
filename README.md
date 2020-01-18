<!-- Variables -->

<!-- Files -->
[changelog]: /CHANGELOG.md
[coc]: /CODE_OF_CONDUCT.md
[contributing]: /CONTRIBUTING.md
[license]: /LICENSE.md
<!-- Images -->
[image1]: /screenshots/check-overview.png
[image2]: /screenshots/file-annotation.png
[logo]: /screenshots/rubocop-linter-action.png

<!-- End Variables -->

![Rubocop Linter Action][logo]

![Version Number](https://img.shields.io/static/v1?label=Version&message=v3.0.0.rc4&color=blue)
![Linters](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Linters/badge.svg)
![Tests](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Test/badge.svg)
[![Changelog](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Changelog/badge.svg)][changelog]
[![Documentation Status](https://readthedocs.org/projects/rubocop-linter-action/badge/?version=latest)](https://rubocop-linter-action.readthedocs.io/en/latest/?badge=latest)
[![All Contributors](https://img.shields.io/badge/all_contributors-8-orange.svg?style=flat-square)](#contributors)

# Rubocop Linter Action

Rubocop Linter Action is a GitHub Action to run [Rubocop](https://github.com/rubocop-hq/rubocop) against your Ruby codebase and output the results in the [GitHub Checks UI](https://developer.github.com/changes/2018-05-07-new-checks-api-public-beta/).

If you are submitting an issue, please use our [reproduction template](https://github.com/handcars/rubocop-linter-action-reproduction-template).

## Introduction

This GitHub Action provides a way to easily run Rubocop on your Ruby or Ruby on Rails project. While it is possible to write a custom GitHub Action to run Rubocop on your codebase, this action takes that functionality one step further using the Checks API. After the Rubocop Linter Action runs Rubocop against your Ruby code, it will create annotations that you can easily view in the GitHub UI, matched up with the offending code.

Since GitHub Actions and the Checks API are continually changing, it is possible that there will be breaking API changes that affect this action. If so, please open an issue and we will look into it as soon as we can. Thank you for using this project! :heart:

## Usage

### Documentation

**Please view the [official documentation](https://rubocop-linter-action.readthedocs.io) for more detailed instructions**, including how to setup and use a configuration file to customize the action. Note that you can set the version for the documentation you are viewing in the bottom right.

> NOTE: The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty pull_requests array.

This is straight out of GitHub's documentation. Put simply, this action won't work correctly on pull requests from a forked repository as is. I am open to a PR that will just output the results of the RuboCop run to the actions log if someone would like to take a shot at adding that!

### Quickstart

Default usage, similar to running `gem install rubocop && rubocop` from your command line:

```yaml
- name: Rubocop Linter Action
  uses: andrewmcodes/rubocop-linter-action@v3.0.0.rc4
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Screenshots

![Rubocop Linter Checks Overview][image1]
![Rubocop Linter File Annotation][image2]

## Community

### Changelog

[View our Changelog][changelog]

### Contributing

[Contributing Guide][contributing]

### Code of Conduct

[Code of Conduct][coc]

### License

[MIT][license]

## Other Ruby GitHub Actions

- [andrewmcodes/haml-lint-action](https://github.com/andrewmcodes/haml-lint-action).
- [andrewmcodes/standardrb-action](https://github.com/andrewmcodes/standardrb-action).

## Contributors

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
    <td align="center"><a href="https://github.com/erichmachado"><img src="https://avatars0.githubusercontent.com/u/613422?v=4" width="100px;" alt=""/><br /><sub><b>Erich Soares Machado</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=erichmachado" title="Code">💻</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/issues?q=author%3Aerichmachado" title="Bug reports">🐛</a> <a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=erichmachado" title="Tests">⚠️</a></td>
    <td align="center"><a href="https://github.com/seerahulsingh"><img src="https://avatars1.githubusercontent.com/u/4716928?v=4" width="100px;" alt=""/><br /><sub><b>Rahul Singh</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/issues?q=author%3Aseerahulsingh" title="Bug reports">🐛</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
