[changelog]: /CHANGELOG.md
[coc]: /CODE_OF_CONDUCT.md
[contributing]: /CONTRIBUTING.md
[license]: /LICENSE.md
[image1]: /screenshots/check-overview.png
[image2]: /screenshots/file-annotation.png
[logo]: /screenshots/rubocop-linter-action.png
[code-of-conduct]: CODE_OF_CONDUCT.md

Hey, there! 👋

This project is done in terms of features. If the project is severely broken due to a change in GitHub or RuboCop, it will be archived at that time and left to those that care about it to fork, fix, and maintain.

I will be happy to review your pull request, but will not be adding any more myself, and make no guarantees I will accept anything that adds behavior. Please read the [introduction](#introduction) for my thoughts on why you should not use this action.

This being said, I will be happy to give you contributor access if you're interested in becoming a maintainer. If I don't respond within a day or two through issues, you may email me (for this reason **only**) or DM me on [Twitter](https://twitter.com/andrewmcodes). Truthfully this project makes me feel very burnt out whenever I am around it, especially since I have not actually used it in months.

Thanks for understanding,

-- [@andrewmcodes](https://github.com/andrewmcodes)

![RuboCop Linter Action][logo]

[![codecov](https://codecov.io/gh/andrewmcodes/rubocop-linter-action/branch/master/graph/badge.svg)](https://codecov.io/gh/andrewmcodes/rubocop-linter-action)
[![CodeFactor](https://www.codefactor.io/repository/github/andrewmcodes/rubocop-linter-action/badge)](https://www.codefactor.io/repository/github/andrewmcodes/rubocop-linter-action)
![Linters](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Linters/badge.svg)
![Tests](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Test/badge.svg)
[![Changelog](https://github.com/andrewmcodes/rubocop-linter-action/workflows/Changelog/badge.svg)][changelog]

# RuboCop Linter Action

RuboCop Linter Action is a GitHub Action to run [RuboCop](https://github.com/rubocop-hq/rubocop) against your Ruby codebase and output the results in the [GitHub Checks UI](https://developer.github.com/changes/2018-05-07-new-checks-api-public-beta/).

> IMPORTANT: The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty pull_requests array.

This is straight out of [GitHub's documentation](https://docs.github.com/en/rest/reference/checks#create-a-check-run).

Put simply, **this action will not work on pull requests from a forked repository**, making it basically useless for open source repositories.

**PLEASE DO NOT USE THIS ACTION**, and instead follow [the Rails way](https://github.com/rails/rails/blob/4a78dcb326e57b5035c4df322e31875bfa74ae23/.github/workflows/rubocop.yml#L1).

## Quickstart

> IMPORTANT: This action does not run `bundle install` by default. In order to install gems via bundler, you will need to update your configuration file. See more below.

The default usage, similar to running `gem install rubocop && rubocop` from your command line:

```yaml
- name: RuboCop Linter Action
  uses: andrewmcodes/rubocop-linter-action@v3.2.0
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Introduction

This GitHub Action provides a way to easily run RuboCop on your codebase, and output the results to the view via [GitHub Checks](https://docs.github.com/en/rest/reference/checks)

While it is **recommended** to write a custom GitHub Action to run RuboCop on your codebase, this action takes that functionality one step further using Checks. After the RuboCop Linter Action runs RuboCop against your Ruby code, it will create annotations that you can easily view in the GitHub UI, matched up with the offending code.

At this point the Checks API has been in beta over two years, and it is still possible that there will be breaking API changes that affect this action. If this occurs, please open a pull request to fix it.

**Are you sure you need this action?**

I would truly recommend **not** using this action. The potential for random breaking changes from GitHub will always be a looming threat and I have ascertained people are using this action as a crutch to avoid what they really ought be doing.

If you find yourself constantly having to wade through RuboCop errors in GitHub, the fix is to not allow them to get to GitHub broken in the first place. I would highly suggest using a tool like [lefthook](https://github.com/Arkweid/lefthook) or similar to flag or fix failing cops before they get to GitHub Actions, saving you and your team time and removing the need for this action.

## Usage

- [RuboCop Linter Action](#rubocop-linter-action)
  - [Quickstart](#quickstart)
  - [Introduction](#introduction)
  - [Usage](#usage)
    - [Screenshots](#screenshots)
    - [Configuration](#configuration)
    - [Inputs](#inputs)
    - [Simple Config](#simple-config)
    - [Default Config](#default-config)
    - [Version Constraints](#version-constraints)
    - [Spec](#spec)
    - [Usage](#usage-1)
    - [Example Workflow](#example-workflow)
    - [Updates](#updates)
    - [RuboCop Docs](#rubocop-docs)
    - [FAQ](#faq)
  - [Config options](#config-options)
    - [exit_on_failure](#exit_on_failure)
  - [Community](#community)
    - [Changelog](#changelog)
    - [Contributing](#contributing)
    - [Code of Conduct](#code-of-conduct)
    - [License](#license)

### Screenshots

![RuboCop Linter File Annotation][image2]

<details>
  <summary>Another Screenshot ⬇️</summary>

![RuboCop Linter Checks Overview][image1]

</details>

### Configuration

### Inputs

**`action_config_path`**

**Defintion**

The only input accepted for the action, which allows you to specify a custom location for the action config file.

**Default**

`.github/config/rubocop_linter_action.yml`

### Simple Config

This is simple config file showing how you could choose to change the version numbers, but use defaults for the rest:

```yml
# .github/config/rubocop_linter_action.yml

versions:
  - rubocop-rails
  - rubocop-performance: "1.5.1"
  - rubocop-minitest: "latest"
  - rubocop-rspec: "1.37.0"
```

### Default Config

```yml
# .github/config/rubocop_linter_action.yml

# Description: The name of the check that will be created.
# Valid Options: A reasonably sized string.
# Default: 'RuboCop Action'
check_name: "RuboCop Results"

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
  - rubocop-performance: "1.5.1"
  - rubocop-rspec: "1.37.0"

# Description: RuboCop configuration file path relative to the workspace.
# Valid options: A valid file path inside of the workspace.
# Default: nil
# Note: This does not need to be filled out for RuboCop to still find your config.
# Resource: https://rubocop.readthedocs.io/en/stable/configuration/
rubocop_config_path: ".rubocop.yml"

# Run all cops enabled by configuration except this list.
# Valid options: list of valid cop(s) and/or departments.
# Default: nil
# Resource: https://rubocop.readthedocs.io/en/stable/cops/
rubocop_excluded_cops:
  - "Style/FrozenStringLiteralComment"

# Minimum severity for exit with error code
# Valid options: 'refactor', 'convention', 'warning', 'error', or 'fatal'.
# Default: 'warning'
# Resource: https://rubocop.readthedocs.io/en/stable/configuration/#severity
rubocop_fail_level: "warning"

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

# The scope of code that RuboCop should lint. Use this if you only want to lint changed files. If this is not set
# or not equal to 'modified', RuboCop is run against the entire codebase. Note that this will not work on the master branch.
# Valid options: 'modified'
# Default: nil
check_scope: "modified"

# The base branch against which changes will be compared, if check_scope config is set to 'modified'.
# This setting is not used if check_scope != 'modified'.
# Valid options: 'origin/another_branch'
# Default: 'origin/master'
base_branch: "origin/master"
```

### Version Constraints

It is **highly** recommend you tie yourself to a version and do not do the following. I promise your life will be much easier. 😇

```yml
# ❌ Bad, use at your own risk!
uses: andrewmcodes/rubocop-linter-action@master

# ✅ Good
uses: andrewmcodes/rubocop-linter-action@v2.0.0
```

### Spec

```yml
action_config_path:
  description: "Define a path to your optional action config file."
  required: false
  default: ".github/config/rubocop_linter_action.yml"
```

### Usage

```yml
with:
  action_config_path: ".github/actions/config/rubocop.yml"
```

### Example Workflow

Here is an example workflow file incorporating RuboCop Linter Action with customized usage based on the values in your configuration file:

```yaml
name: Linters

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: RuboCop Linter
        uses: andrewmcodes/rubocop-linter-action@v3.2.0
        with:
          action_config_path: ".github/config/rubocop_linter_action.yml" # Note: this is the default location
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Updates

Since the action will default to the latest RuboCop release, you may run into isues with outdated config options that are specified in your `.rubocop.yml`. To easily upgrade your config, use [mry](https://github.com/pocke/mry).

### RuboCop Docs

Several of the config options map directly to RuboCop's inputs. Check [their documentation](https://rubocop.readthedocs.io/en/stable/basic_usage/#command-line-flags) for help or more info.

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
check_scope: "modified"
```

Please note that this will not work on commits to master. If you have an idea on how to make this work, please open an issue or PR!

**4. My GitHub Checks results don't match the output of running RuboCop locally.**

Make sure you're running the same version of RuboCop that the linter is using. If using Bundler, try running `bundle update rubocop`. If you need the linter to use an older version, you can specify it in the config file:

```yaml
versions:
  - rubocop: "0.88.0"
```

## Config options

### exit_on_failure

Stop the workflow execution if the linter returns some failures.

```yaml
- name: RuboCop Linter Action
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

If you would like to contribute, please limit to bug fixes. At this point, you will need to use your own fork if you want a big change in behavior.

Please make sure to read the [code of conduct][code-of-conduct] before submitting issues or pull requests.

To lend a helping hand:

- [Fork the repository](https://help.github.com/articles/fork-a-repo/)
- Make your desired changes
- [Create a pull request](https://help.github.com/articles/creating-a-pull-request/)
- Ensure tests are passing

Include `[ci skip]` in your commit message if the change does not change the meaning of code (e.g., documentation updates).

### Code of Conduct

[Code of Conduct][coc]

### License

[MIT][license]
