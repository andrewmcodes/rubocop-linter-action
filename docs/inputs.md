# Inputs

With previous versions, we accepted several inputs. This has all gone away with the new configuration file. The only input accepted for the action is `action_config_path`, which defines where your configuration file for the action is if it is not at `.github/config/rubocop_linter_action.yml`.

## Spec

```yml
action_config_path:
  description: 'Define a path to your optional action config file.'
  required: false
  default: '.github/config/rubocop_linter_action.yml'
```

## Usage

```yml
with:
  action_config_path: '.github/actions/config/rubocop.yml'
```
