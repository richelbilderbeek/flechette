# FAQ

## How to install BEAST2?

See [how to install BEAST2](https://github.com/ropensci/beastier/blob/master/install_beast2.md).

## How can I indicate a feature that I miss?

Submit an Issue.

## How can I submit code?

See [CONTRIBUTING](../CONTRIBUTING.md), at 'Submitting code'

## How can I submit a bug?

See [CONTRIBUTING](../CONTRIBUTING.md), at 'Submitting bugs' 

## How can I indicate something else?

Submit an Issue. Or send an email to Richel Bilderbeek.

## How do I reference to this work?

Article is still in preperation.

## Why the name?

`raket` is something fast.

## Why no 100% code coverage?

Because `raket` does not intend to be a fully-fledged
package. Most things it does are intended to run locally.

## Misc


### What software do you use to create the diagrams?

Dia:

 * [homepage](https://wiki.gnome.org/Apps/Dia/)
 * [Wikipedia](https://en.wikipedia.org/wiki/Dia_(software))

### How to create the dependency graph from the `.dot` file?

```
dot -Tps dependencies.dot -o dependencies.ps
convert dependencies.ps dependencies.png
```
