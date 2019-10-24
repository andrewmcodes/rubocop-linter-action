FROM ruby:2.6.5-alpine

RUN apk add --update build-base git

LABEL com.github.actions.name="Rubocop Linter"
LABEL com.github.actions.description="Lint your Ruby code"
LABEL com.github.actions.icon="code"
LABEL com.github.actions.color="red"

LABEL maintainer="Andrew Mason <andrewmcodes@protonmail.com>"

COPY lib /action/lib
RUN gem install bundler

ENTRYPOINT ["/action/lib/entrypoint.sh"]
