FROM ruby:2.7.0-alpine

RUN apk --no-cache add build-base git

LABEL "repository"="https://github.com/andrewmcodes/rubocop-linter-action"
LABEL "maintainer"="Andrew Mason <andrewmcodes@protonmail.com>"
LABEL "version"="3.0.0"

COPY lib /action/lib
COPY README.md LICENSE entrypoint.sh /

RUN gem install bundler:2.1.4

ENTRYPOINT ["/entrypoint.sh"]
