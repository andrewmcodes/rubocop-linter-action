#!/bin/sh

set -e

if ["${INPUT_VERSION}" != ""]
then
  gem install rubocop ${INPUT_ADDITIONAL_GEMS}
else
  gem install rubocop -v ${INPUT_VERSION} ${INPUT_ADDITIONAL_GEMS}
fi

ruby /action/lib/index.rb
