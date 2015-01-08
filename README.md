# git-switch

List latests used branches

## Synopsis

```
git switch [<options>]
```

## Description

List lastest used branches. By used we mean checked-out at some point.
It also has an interactive mode which allows you to easily checkout one
of the branches in the list.

## Options

| Option                | Description                     |
|-----------------------|---------------------------------|
| `-m` `--modified`     | Show recently modified branches. By default it lists by checkout history. |
| `-i` `--interactive`  | Use interactive mode            |
| `-c` `--count number` | Show number of branches         |

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

* Marcelo Dominguez (@marpo60)
* Santiago Ferreira (@san650)
* Daniel Gomez de Souza (@eldano)

## License

git-switch is licensed under the MIT license.

See LICENSE for the full license text.
