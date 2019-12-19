# FAQ

_If you cannot find an answer here that you think should be included, let us know!!_

**1. The GitHub Check summary says I have `rand(51..1_000_000)` offenses, but I only see 50! What gives?**

The Checks API limits the number of annotations to a maximum of 50 per API request. To create more than 50 annotations, you have to make multiple requests to the Update a check run endpoint. See [here](https://developer.github.com/v3/checks/runs/#output-object) for more info. We would be open to a PR to add this feature though.

**2. Why is my check result being shown under the wrong header?**

There is a bug with Checks that might cause your runs to get jumbled in the UI, but they will all still run and render annotations in the diff correctly. Hopefully this will get fixed or we figure out that we are doing something wrong that is fixable.

**3. How come I can't create checks on forked repositories? [(example)](https://github.com/ruby/spec/commit/1cfa9f188e8342993d149807210b6777189cfe3f/checks?check_suite_id=335929828)**

This is currently how the GitHub Checks API works for security reasons. I believe we will get some improvements in the future, which may fix this.
