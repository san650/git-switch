# git-switch

Allows to checkout easily previously used branches. It can list branches by checked out date or by modified date, that is, branches with newest commits.

![git-switch showcase](http://i.imgur.com/cJGhNDs.gif)

## Synopsis

```
git switch [<options>]
```

or

```
git switch -
```

to checkout previous branch

## Description

List latest used branches. By used we mean branches that were modified at some point.
It also has an interactive mode which allows you to easily checkout one
of the branches in the list.

## Options

| Option                  | Description                     |
|-------------------------|---------------------------------|
| `-o` `--checked-out`    | Show recently checked out branches. By default it lists by branch's modified date. |
| `-m` `--modified`       | Show last modified branches |
| `-i` `--no-interactive` | Don't use interactive mode. Interactive by default. |
| `-c` `--count <number>` | Show number of branches. By default it shows nine.|
| `-v` `--version`        | Show version number and quit |

## Configurations

You can configure git switch to do "checked-out" order by default

```sh
git config --add switch.order checked-out
```

You can also configure the number of branches to show

```sh
git config --add switch.count 5
```

## Installation

You can install it on OS X using Homebrew

```sh
$ brew tap san650/git-switch
$ brew install git-switch
```

Or you can clone the repository and link git-switch.rb to your bin directory

```sh
$ git clone https://github.com/san650/git-switch.git
$ cd git-switch
$ ln -s $(pwd)/git-switch.rb /usr/bin/git-switch
```

## Update

With Homebrew

```sh
$ brew upgrade git-switch
```

Or using the git repository

```sh
$ cd git-switch
$ git fetch origin
$ git checkout v0.2
```

## Uninstall

```sh
$ brew uninstall git-switch
$ brew untap san650/git-switch
```

## Tests

Ruby 1.8.7

```sh
$ ruby -rubygems tests/acceptance.rb
```

Ruby 1.9+

```sh
$ ruby tests/acceptance.rb
```

## Contributors

* Marcelo Dominguez ([@marpo60](http://github.com/marpo60))
* Santiago Ferreira ([@san650](http://github.com/san650))
* Daniel Gomez de Souza ([@eldano](http://github.com/eldano))

## License

git-switch is licensed under the MIT license.

See [LICENSE](https://raw.githubusercontent.com/san650/git-switch/master/LICENSE) for the full license text.
