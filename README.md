# git-switch

List latests used branches

## Synopsis

```
git switch [<options>]
```

## Description

List latest used branches. By used we mean branches that were modified at some point.
It also has an interactive mode which allows you to easily checkout one
of the branches in the list.

## Options

| Option                  | Description                     |
|-------------------------|---------------------------------|
| `-o` `--checked-out`    | Show recently checked out branches. By default it lists by branch's modified date. |
| `-i` `--no-interactive` | Don't use interactive mode. Interactive by default. |
| `-c` `--count <number>` | Show number of branches. |

## Installation

Clone git-switch repository

```sh
$ git clone https://github.com/san650/git-switch.git
```

Link git-switch.rb to your `bin` directory

```sh
$ cd git-switch
$ ln -s $(pwd)/git-switch.rb /usr/bin/git-switch
```

## Contributors

* Marcelo Dominguez ([@marpo60](http://github.com/marpo60))
* Santiago Ferreira ([@san650](http://github.com/san650))
* Daniel Gomez de Souza ([@eldano](http://github.com/eldano))

## License

git-switch is licensed under the MIT license.

See [LICENSE](https://raw.githubusercontent.com/san650/git-switch/master/LICENSE) for the full license text.
