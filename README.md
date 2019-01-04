# raket

```
raket is not intended to be fully tested!
The experiment itself is the test
```

Branch|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)|[![AppVeyor logo](pics/AppVeyor.png)](https://www.appveyor.com)|[![Codecov logo](pics/Codecov.png)](https://www.codecov.io)
---|---|---|---
master|[![Build Status](https://travis-ci.org/richelbilderbeek/raket.svg?branch=master)](https://travis-ci.org/richelbilderbeek/raket)|[![Build status](https://ci.appveyor.com/api/projects/status/pm0injx1acgrj6gp/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/raket/branch/master)|[![codecov.io](https://codecov.io/github/richelbilderbeek/raket/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/raket/branch/master)
develop|[![Build Status](https://travis-ci.org/richelbilderbeek/raket.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/raket)|[![Build status](https://ci.appveyor.com/api/projects/status/pm0injx1acgrj6gp/branch/develop?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/raket/branch/develop)|[![codecov.io](https://codecov.io/github/richelbilderbeek/raket/coverage.svg?branch=develop)](https://codecov.io/github/richelbilderbeek/raket/branch/develop)

 * [raket](https://github.com/richelbilderbeek/raket) provides the R code used by [1]
 * [raket_werper](https://github.com/richelbilderbeek/raket_werper) provides the scripts used by [1]

`raket` is an R package that uses

 * [PBD](https://github.com/rsetienne/PBD): to generate incipient species trees and sample a species tree 
 * [pirouette](https://github.com/richelbilderbeek/pirouette): to convert a species phylogeny to a posterior 
 * [nLTT](https://github.com/richelbilderbeek/nLTT): to compare a species tree to all species trees in the posterior


## Download raket locally

```
git clone https://github.com/richelbilderbeek/raket
```

## Pipeline

See [the README in the scripts folder](scripts/README.md)

## Installation

If you use the `devtools` R package, this is easy:

```
devtools::install_github("richelbilderbeek/raket")
```

`raket` assumes that BEAST2 is installed. To install BEAST2, from R do:

```{r}
beastier::install_beast2()
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
[beautier](https://github.com/ropensci/beautier)|[![Build Status](https://travis-ci.org/ropensci/beautier.svg?branch=master)](https://travis-ci.org/ropensci/beautier)|[![codecov.io](https://codecov.io/github/ropensci/beautier/coverage.svg?branch=master)](https://codecov.io/github/ropensci/beautier/branch/master)
[beastier](https://github.com/ropensci/beastier)|[![Build Status](https://travis-ci.org/ropensci/beastier.svg?branch=master)](https://travis-ci.org/ropensci/beastier)|[![codecov.io](https://codecov.io/github/ropensci/beastier/coverage.svg?branch=master)](https://codecov.io/github/ropensci/beastier/branch/master)
[phangorn](https://github.com/KlausVigo/phangorn)|[![Build Status](https://travis-ci.org/KlausVigo/phangorn.svg?branch=master)](https://travis-ci.org/KlausVigo/phangorn)|[![codecov.io](https://codecov.io/github/KlausVigo/phangorn/coverage.svg?branch=master)](https://codecov.io/github/KlausVigo/phangorn/branch/master)
[pirouette](https://github.com/richelbilderbeek/pirouette)|[![Build Status](https://travis-ci.org/richelbilderbeek/pirouette.svg?branch=master)](https://travis-ci.org/richelbilderbeek/pirouette)|[![codecov.io](https://codecov.io/github/richelbilderbeek/pirouette/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/pirouette/branch/master)
[tracerer](https://github.com/ropensci/tracerer)|[![Build Status](https://travis-ci.org/ropensci/tracerer.svg?branch=master)](https://travis-ci.org/ropensci/tracerer)|[![codecov.io](https://codecov.io/github/ropensci/tracerer/coverage.svg?branch=master)](https://codecov.io/github/ropensci/tracerer/branch/master)

## External links

 * [BEAST2 GitHub](https://github.com/CompEvol/beast2)

## References

 * [1] Bilderbeek, Richel JC, and Rampal S. Etienne. "The error when inferring phylogenies with incipient species by a birth-death model.". First registration at the [Open Source Framework](https://osf.io/) on 2018-06-14. Second registration at the [Open Source Framework](https://osf.io/) on 2018-09-03.

![First registration of the article](pics/osf_registration_1.png)
