FROM ruby:2.6.5-alpine

RUN apk add --update build-base git

LABEL "com.github.actions.name"="Rubocop Linter"
LABEL "com.github.actions.description"="A GitHub Action that lints your Ruby code with Rubocop!"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/andrewmcodes/rubocop-linter-action"
LABEL "maintainer"="Andrew Mason <andrewmcodes@protonmail.com>"
LABEL "version"="1.0.0"


COPY lib /action/lib
RUN gem install bundler

ENTRYPOINT ["/action/lib/entrypoint.sh"]
