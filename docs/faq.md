# FAQ

_If you cannot find an answer here that you think should be included, let us know!!_

**1. Why is my check result being shown under the wrong header?**

There is a bug with Checks that might cause your runs to get jumbled in the UI, but they will all still run and render annotations in the diff correctly. Hopefully this will get fixed or we figure out that we are doing something wrong that is fixable.

**2. How come I can't create checks on forked repositories? [(example)](https://github.com/ruby/spec/commit/1cfa9f188e8342993d149807210b6777189cfe3f/checks?check_suite_id=335929828)**

> NOTE: The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty pull_requests array.

This is straight out of GitHub's documentation. Put simply, this action won't work correctly on pull requests from a forked repository as is.

I am open to a PR that will just output the results of the RuboCop run to the actions log if someone would like to take a shot at adding that!
