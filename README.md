# git-switch

List last nine used branches

## Synopsis

```
git switch [<options>]
```

## Description

List last nine branches used. By used we mean checked-out at some point.
It also has an interactive mode which allows you to easily checkout one
of the branches in the list.

## Options

| Option               | Description                     |
|----------------------|---------------------------------|
| `-m` `--modified`    | Show recently modified branches |
| `-i` `--interactive` | Use interactive mode            |

## Installation

Clone git-switch repository

```sh
$ git clone https://github.com/san650/git-switch.git
```

Link git-switch.rb to your `bin` directory

```sh
$ ln -s git-switch.rb /usr/bin/git-switch
```

## License

git-switch is licensed under the MIT license.

See LICENSE for the full license text.
