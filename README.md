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

![Version Number](https://img.shields.io/static/v1?label=Version&message=v3.2.0&color=blue)
[![codecov](https://codecov.io/gh/andrewmcodes/rubocop-linter-action/branch/master/graph/badge.svg)](https://codecov.io/gh/andrewmcodes/rubocop-linter-action)
[![CodeFactor](https://www.codefactor.io/repository/github/andrewmcodes/rubocop-linter-action/badge)](https://www.codefactor.io/repository/github/andrewmcodes/rubocop-linter-action)
![Linters](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Linters/badge.svg)
![Tests](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Test/badge.svg)
[![Changelog](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Changelog/badge.svg)][changelog]
[![Documentation Status](https://readthedocs.org/projects/rubocop-linter-action/badge/?version=latest)](https://rubocop-linter-action.readthedocs.io/en/latest/?badge=latest)
[![All Contributors](https://img.shields.io/badge/all_contributors-12-orange.svg?style=flat-square)](#contributors)

# Rubocop Linter Action

Rubocop Linter Action is a GitHub Action to run [Rubocop](https://github.com/rubocop-hq/rubocop) against your Ruby codebase and output the results in the [GitHub Checks UI](https://developer.github.com/changes/2018-05-07-new-checks-api-public-beta/).

If you are submitting an issue, please use our [reproduction template](https://github.com/handcars/rubocop-linter-action-reproduction-template).

## Introduction

This GitHub Action provides a way to easily run Rubocop on your Ruby or Ruby on Rails project. While it is possible to write a custom GitHub Action to run Rubocop on your codebase, this action takes that functionality one step further using the Checks API. After the Rubocop Linter Action runs Rubocop against your Ruby code, it will create annotations that you can easily view in the GitHub UI, matched up with the offending code.

Since GitHub Actions and the Checks API are continually changing, it is possible that there will be breaking API changes that affect this action. If so, please open an issue and we will look into it as soon as we can. Thank you for using this project! :heart:

## Github

> NOTE: The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty pull_requests array.

This is straight out of GitHub's documentation. Put simply, this action won't work correctly on pull requests from a forked repository as is. I am open to a PR that will just output the results of the RuboCop run to the actions log if someone would like to take a shot at adding that!

## Usage

1. [Quickstart](#quickstart)
    - [Screenshots](#screenshots)
2. [Configuration](#configuration)
    - [Documentation](#documentation)
    - [Example](#example)
    - [Version Constraints](#version-constraints)
3. [Inputs](#inputs)
    - [Spec](#spec)
    - [Usage](#usage)
4. [Example Workflow](#example-workflow)
5. [Updates](#updates)
6. [Rubocop Docs](#rubocop-docs)
7. [FAQ](#faq)

### Quickstart

Default usage, similar to running `gem install rubocop && rubocop` from your command line:

```yaml
- name: Rubocop Linter Action
  uses: andrewmcodes/rubocop-linter-action@v3.2.0
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Screenshots

![Rubocop Linter Checks Overview][image1]
![Rubocop Linter File Annotation][image2]

### Configuration

We use a configuration file to configure the action. This allows us to have a very clean action, and minimize problems when using GitHub Action inputs. You do not have to have a config file if you want to use the base settings, but if you want to customize the action, you will need to add one. You can specify where the config lives by using the inputs, but it will default to `.github/config/rubocop_linter_action.yml` if it is not specified.

### Documentation

```yml
# .github/config/rubocop_linter_action.yml

# Description: The name of the check that will be created.
# Valid Options: A reasonably sized string.
# Default: 'Rubocop Action'
check_name: 'Rubocop Results'

# Description: Versions required to run your RuboCop checks.
# Valid options: RuboCop and any RuboCop extension, by default the latest gem version will be used. You can explicitly state that
# (not required) or use a version number, like '1.5.1'.
# Default:
#   versions:
#     - rubocop: 'latest'
versions:
  - rubocop
  - rubocop-rails
  - rubocop-minitest
  - rubocop-performance: '1.5.1'
  - rubocop-rspec: '1.37.0'

# Description: Rubocop configuration file path relative to the workspace.
# Valid options: A valid file path inside of the workspace.
# Default: nil
# Note: This does not need to be filled out for Rubocop to still find your config.
# Resource: https://rubocop.readthedocs.io/en/stable/configuration/
rubocop_config_path: '.rubocop.yml'

# Run all cops enabled by configuration except this list.
# Valid options: list of valid cop(s) and/or departments.
# Default: nil
# Resource: https://rubocop.readthedocs.io/en/stable/cops/
rubocop_excluded_cops:
  - 'Style/FrozenStringLiteralComment'

# Minimum severity for exit with error code
# Valid options: 'refactor', 'convention', 'warning', 'error', or 'fatal'.
# Default: 'warning'
# Resource: https://rubocop.readthedocs.io/en/stable/configuration/#severity
rubocop_fail_level: 'warning'

# Whether or not to use --force-exclusion when building the rubocop command. Use this if you are only linting modified
# files and typically excluded files have been changed. For example, if you exclude db/schema.rb in your rubocop.yml
# but a change gets made, then with the check_scope config set to 'modified' rubocop will lint db/schema.rb. If you set
# this to true, rubocop will ignore it.
# Valid options: true || false
# Default: false
rubocop_force_exclusion: true

# Instead of installing gems from rubygems, we can run `bundle install` on your project,
# you would need to do this if you are using something like 'rubocop-github' or if you don't
# want to list out dependencies with the `versions` key.
# Valid options: true || false
# Default: false
bundle: false

# The scope of code that Rubocop should lint. Use this if you only want to lint changed files. If this is not set
# or not equal to 'modified', Rubocop is run against the entire codebase. Note that this will not work on the master branch.
# Valid options: 'modified'
# Default: nil
check_scope: 'modified'

# The base branch against which changes will be compared, if check_scope config is set to 'modified'.
# This setting is not used if check_scope != 'modified'.
# Valid options: 'origin/another_branch'
# Default: 'origin/master'
base_branch: 'origin/master'
```

### Example

```yml
# .github/config/rubocop_linter_action.yml

versions:
  - rubocop-rails
  - rubocop-performance: '1.5.1'
  - rubocop-minitest: 'latest'
  - rubocop-rspec: '1.37.0'
```


### Version Constraints

It is **highly** recommend you tie yourself to a version and do not do the following. I promise your life will be much easier. 😇

```yml
# ❌ Danger, sometimes I break things!
uses: andrewmcodes/rubocop-linter-action@master

# ✅ Much better.
uses: andrewmcodes/rubocop-linter-action@v2.0.0
```

### Inputs

With previous versions, we accepted several inputs. This has all gone away with the new configuration file. The only input accepted for the action is `action_config_path`, which defines where your configuration file for the action is if it is not at `.github/config/rubocop_linter_action.yml`.

### Spec

```yml
action_config_path:
  description: 'Define a path to your optional action config file.'
  required: false
  default: '.github/config/rubocop_linter_action.yml'
```

### Usage

```yml
with:
  action_config_path: '.github/actions/config/rubocop.yml'
```
### Example Workflow

Here is an example workflow file incorporating Rubocop Linter Action with customized usage based on the values in your configuration file:

```yaml
name: Linters

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Rubocop Linter
      uses: andrewmcodes/rubocop-linter-action@v3.2.0
      with:
        action_config_path: '.github/config/rubocop_linter_action.yml' # Note: this is the default location
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Go [here](https://github.com/handcars/rubocop-linter-action-playground/blob/master/.github/workflows) to see more examples!**

### Updates

Since the action will default to the latest Rubocop release, you may run into isues with outdated config options that are specified in your `.rubocop.yml`. To easily upgrade your config, use [mry](https://github.com/pocke/mry).

### Rubocop Docs

Several of the config options map directly to Rubocop's inputs. Check [their documentation](https://rubocop.readthedocs.io/en/stable/basic_usage/#command-line-flags) for help or more info.

### FAQ

_If you cannot find an answer here that you think should be included, let us know!!_

**1. Why is my check result being shown under the wrong header?**

There is a bug with Checks that might cause your runs to get jumbled in the UI, but they will all still run and render annotations in the diff correctly. Hopefully this will get fixed or we figure out that we are doing something wrong that is fixable.

**2. How come I can't create checks on forked repositories? [(example)](https://github.com/ruby/spec/commit/1cfa9f188e8342993d149807210b6777189cfe3f/checks?check_suite_id=335929828)**

> NOTE: The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty pull_requests array.

This is straight out of GitHub's documentation. Put simply, this action won't work correctly on pull requests from a forked repository as is.

I am open to a PR that will just output the results of the RuboCop run to the actions log if someone would like to take a shot at adding that!

**3. The modified flag is not working!**

If you specify the following in your config file:

```yaml
check_scope: 'modified'
```

Please note that this will not work on commits to master. If you have an idea on how to make this work, please open an issue or PR!

**4. My GitHub Checks results don't match the output of running Rubocop locally.**

Make sure you're running the same version of Rubocop that the linter is using. If using Bundler, try running `bundle update rubocop`. If you need the linter to use an older version, you can specify it in the config file:

```yaml
versions:
  - rubocop: '0.88.0'
```

## Config options

### exit_on_failure

Stop the workflow execution if the linter returns some failures.

```yaml
- name: Rubocop Linter Action
  uses: andrewmcodes/rubocop-linter-action@v3.2.0
  with:
    exit_on_failure: true
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

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
    <td align="center"><a href="https://github.com/es50678"><img src="https://avatars1.githubusercontent.com/u/17823824?v=4" width="100px;" alt=""/><br /><sub><b>Eduardo Hernandez Soto</b></sub></a><br /><a href="https://github.com/andrewmcodes/rubocop-linter-action/commits?author=es50678" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
