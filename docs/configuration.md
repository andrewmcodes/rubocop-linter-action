# Available Inputs

| **Input Parm Name** | **Required** | **Default Value** | **Description**                                                                                       | **Examples of Equivalent Local Commands**                                  |
| ------------------- | ------------ | ----------------- | ----------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| bundle              | false        | false             | If you would like to run `bundle install` on your project instead of `gem install`                    | `bundle install --deployment --jobs 4 --retry 3`                           |
| version             | false        | latest GA         | Define a later version of rubocop if latest is not needed                                             | `gem install rubocop -v 0.76.0`                                            |
| additional_gems     | false        |                   | Additional Gems can be installed via one line with spaces and commands are supported like a version   | `gem install rubocop-rails rubocop-performance 'rubocop-i18n:2.0.0'`         |
| config_path         | false        | repo ./           | If the config path is another spot in the repo or not named `.rubocop.yml`                            | `rubocop -c .rubocop_config_test.yml`                                      |
| exclude_cops        | false        |                   | Define a list of paths to exclude from being linted.                                                  | `rubocop --except 'Style/FrozenStringLiteralComment Style/StringLiterals'` |
| fail_level          | false        | 'warning'         | Can define `refactor`, `convention`, `warning`, `error` and 'fatal' to cause Rubocop to error out on. | `rubocop --fail-level 'warning'`                                           |
