# Contributing

Awesome that you are reading this.

This GitHub follows the [Contributor Covenant Code of Conduct](doc/code_of_conduct.md).

 * For questions, you can create an Issue
 * Code changes go via Pull Requests

## Which package to contribute to?

`raket` consists out of multiple packages:

If you want to contribute to the creation of BEAST2 XML input file,
go to [beautier](https://github.com/ropensci/beautier/blob/master/CONTRIBUTING.md).

If you want to contribute to how BEAST2 is run,
go to [beastier](https://github.com/richelbilderbeek/beastier/blob/master/CONTRIBUTING.md).

If you want to contribute to how BEAST2 output is parsed,
go to [tracerer](https://github.com/ropensci/tracerer/blob/master/CONTRIBUTING.md)

If you want to contribute to the full BEAST2 pipeline,
go to [babette](https://github.com/richelbilderbeek/babette/blob/master/CONTRIBUTING.md)

If you want to contribute to the conversion of initial phylogeny to alignment,
go to [pirouette](https://github.com/richelbilderbeek/pirouette/blob/master/CONTRIBUTING.md)

If you want to contribute with an overarching idea, you are at the right spot :-) 

## Submitting code

Submitted code should follow these quality guidelines:

 * All tests pass cleanly/silently
 * Code coverage must be 100%
 * Coding style should follow the default style by `lintr`

These are all checked by Travis CI when submitting
a Pull Request. 

Emails with code will not be accepted.

## Submitting bugs

Awesome. These are your options:

 * Add an Issue, with the test that fails
 * Submit a Pull Request, where the test is added to the `tests/testthat` folder
 * Send @richelbilderbeek an email (@richelbilderbeek will make an Issue of it)

Pull Requests should follow the same guidelines as 'Submitting code'.

## Branching policy

 * The `master` branch should always build successfully
 * The `development` branch is for developers

## git usage

To get started working on `raket` do:

```
git clone https://github.com/richelbilderbeek/raket
```

Development is done on the `develop` branch. 
To download and checkout the `develop` branch, 
first go into the `raket` folder (`cd raket`), then do:

```
git checkout -t origin/develop
```

Then the workflow is the common `git` workflow:

```
git pull
git add --all :/
git commit -m "Did something awesome"
git push
```
