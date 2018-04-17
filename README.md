# raket

Branch|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)|[![AppVeyor logo](pics/AppVeyor.png)](https://www.appveyor.com)
---|---|---
master|[![Build Status](https://travis-ci.org/richelbilderbeek/raket.svg?branch=master)](https://travis-ci.org/richelbilderbeek/raket)|[![Build status](https://ci.appveyor.com/api/projects/status/pm0injx1acgrj6gp/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/raket/branch/master)
develop|[![Build Status](https://travis-ci.org/richelbilderbeek/raket.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/raket)|[![Build status](https://ci.appveyor.com/api/projects/status/pm0injx1acgrj6gp/branch/develop?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/raket/branch/develop)

`raket` is an R package that combines:

 * [babette](https://github.com/richelbilderbeek/babette)
 * [pirouette](https://github.com/richelbilderbeek/pirouette)

## Examples

```
None yet
```

## Installation

If you use the `devtools` R package, this is easy:

```
devtools::install_github("richelbilderbeek/raket")
```

`raket` assumes that BEAST2 is installed. To install BEAST2, from R do:

```{r}
library(beastier)
install_beast2()
```

This will download and extract BEAST2 to:

OS|Full path
---|---
Linux|`~/.local/share/beast/bin/beast.jar`
Windows|`C:/Users/<username>/Local/beast/bin/beast.jar`

## FAQ

See [FAQ](doc/faq.md).

## There is a feature I miss

See [CONTRIBUTING](CONTRIBUTING.md), at `Submitting use cases`

## I want to collaborate

See [CONTRIBUTING](CONTRIBUTING.md), at 'Submitting code'

## I think I have found a bug

See [CONTRIBUTING](CONTRIBUTING.md), at 'Submitting bugs' 

## There's something else I want to say

Sure, just add an Issue. Or send an email.

## Package dependencies

Package|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)|[![Codecov logo](pics/Codecov.png)](https://www.codecov.io)
---|---|---
[babette](https://github.com/richelbilderbeek/babette)|[![Build Status](https://travis-ci.org/richelbilderbeek/babette.svg?branch=master)](https://travis-ci.org/richelbilderbeek/babette)|[![codecov.io](https://codecov.io/github/richelbilderbeek/babette/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/babette/branch/master)
[beautier](https://github.com/richelbilderbeek/beautier)|[![Build Status](https://travis-ci.org/richelbilderbeek/beautier.svg?branch=master)](https://travis-ci.org/richelbilderbeek/beautier)|[![codecov.io](https://codecov.io/github/richelbilderbeek/beautier/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/beautier/branch/master)
[beastier](https://github.com/richelbilderbeek/beastier)|[![Build Status](https://travis-ci.org/richelbilderbeek/beastier.svg?branch=master)](https://travis-ci.org/richelbilderbeek/beastier)|[![codecov.io](https://codecov.io/github/richelbilderbeek/beastier/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/beastier/branch/master)
[phangorn](https://github.com/KlausVigo/phangorn)|[![Build Status](https://travis-ci.org/KlausVigo/phangorn.svg?branch=master)](https://travis-ci.org/KlausVigo/phangorn)|[![codecov.io](https://codecov.io/github/KlausVigo/phangorn/coverage.svg?branch=master)](https://codecov.io/github/KlausVigo/phangorn/branch/master)
[pirouette](https://github.com/richelbilderbeek/pirouette)|[![Build Status](https://travis-ci.org/richelbilderbeek/pirouette.svg?branch=master)](https://travis-ci.org/richelbilderbeek/pirouette)|[![codecov.io](https://codecov.io/github/richelbilderbeek/pirouette/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/pirouette/branch/master)
[tracerer](https://github.com/richelbilderbeek/tracerer)|[![Build Status](https://travis-ci.org/richelbilderbeek/tracerer.svg?branch=master)](https://travis-ci.org/richelbilderbeek/tracerer)|[![codecov.io](https://codecov.io/github/richelbilderbeek/tracerer/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/tracerer/branch/master)

## External links

 * [BEAST2 GitHub](https://github.com/CompEvol/beast2)

## References

```
None yet
```
