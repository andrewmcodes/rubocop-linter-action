# Configuration

We use a configuration file to configure the action. This allows us to have a very clean action, and minimize problems when using GitHub Action inputs. You do not have to have a config file if you want to use the base settings, but if you want to customize the action, you will need to add one. You can specify where the config lives by using the inputs, but it will default to `.github/config/rubocop_linter_action.yml` if it is not specified.

## Documentation

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

# Instead of installing gems from rubygems, we can run `bundle install` on your project,
# you would need to do this if you are using something like 'rubocop-github' or if you don't
# want to list out dependencies with the `versions` key.
# Valid options: true || false
# Default: false
bundle: false

# The scope of code that Rubocop should lint. Use this if you only want to lint changed files. If this is not set
# or not equal to 'modified', Rubocop is run against the entire codebase.
# Valid options: 'modified'
# Default: nil
rubocop_check_scope: 'modified'
```

## Example

```yml
# .github/config/rubocop_linter_action.yml

versions:
  - rubocop-rails
  - rubocop-performance: '1.5.1'
  - rubocop-minitest: 'latest'
  - rubocop-rspec: '1.37.0'
```


## Version Constraints

It is **highly** recommend you tie yourself to a version and do not do the following. I promise your life will be much easier. 😇

```yml
# ❌ Danger, sometimes I break things!
uses: andrewmcodes/rubocop-linter-action@master

# ✅ Much better.
uses: andrewmcodes/rubocop-linter-action@v2.0.0
```
