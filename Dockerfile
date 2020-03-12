FROM ruby:2.7.0-alpine

RUN apk --no-cache add build-base git

COPY lib /action/lib
COPY README.md LICENSE entrypoint.sh /

RUN gem install bundler:2.1.4

ENTRYPOINT ["/entrypoint.sh"]
