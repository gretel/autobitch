# autobitch

## Introduction

Script to provide automatism for directory based activation of **Python** (including [`virtualenv`](http://virtualenv.pypa.io/)) and **Ruby** versions.

![cardboard-car-mods](https://cloud.githubusercontent.com/assets/80815/15987938/afd60e66-303d-11e6-8804-cb096b72c1f9.jpg)

Basically, it's just some glueish cardboard code around some tools i love:

* [`direnv`](https://github.com/direnv/direnv)
* [`pyenv`](https://github.com/yyuu/pyenv)
* [`ry`](https://github.com/jneen/ry)

## Concept

### Why?

* Frustration with _mimetic_ recommendations from the _internetz_ (i.e. `rbenv`)
* Seeking for lightweight approaches to solve common issues
    * Have to have various versions (and dependencies) of the aformentioned languages available
* Avoid reinventing wheels - use what is rolling fine already
    * Though, enhance functionality while not bloating up too much
* Support [*distraction-less*](https://en.wikipedia.org/wiki/Interruption_science) workflows
    * More switching than bitching (_comfort_ and _pleasure_)

### Inspiration

For both languages `autobitch` kinda emulates the behaviour of [`pyenv-virtualenv`](https://github.com/yyuu/pyenv-virtualenv).

### Logic

On changing directories `direnv` triggers the call of the `use_auto` functions declared in `autobitch.sh` which in turn check the directory for signs of *Python* and *Ruby* installations.

#### For *Python*:

* check if the directory is managed by `virtualenv`
    * `bin/active` is present and executable
        * change environment variables to *activate* the `virtualenv`
* else check for the presence of a `.python-version` file
    * change environment variables to put the specified version in use
* else leave environment unchanged
    * which results in the system's *Python* being used if present
    * or `pyenv` wrappers managing the *global* version in `PATH`

#### For *Ruby*:

* check for the presence of a `.ruby-version` file
    * change environment variables to put the specified version in use
* else leave environment unchanged
    * which results in the system's *Ruby* being used if present
    * or `ry` wrappers managing the version in `PATH`

> *Ruby* and *Python* differ in concepts (`virtualenv` vs. `gemsets`) while similar levels of seperation can be achieved.

## Installation

### Homebrew

#### Prerequisites

As the shell code provided does wrap around the tools and structure of `pyenv` and `ry` these should be present.

> A short-term goal is to allow `autobitch` to work without any tool but `direnv` as long as the convention (directory structure) of the mentioned tools is respected.

On *OSX* installation of these is easy:

```
$ brew install pyenv
$ brew install ry
```

> Please refer to the documentation of these for further information. Both are lightweight but quite powerful so reading is really recommended.

```bash
$ brew install https://raw.githubusercontent.com/gretel/autobitch/master/autobitch.rb
```

The inclusion of the script needs to be enabled manually.
Please add the following to your .direnvrc:

```bash
use_auto() {
    source_env "$(brew --prefix autobitch)/share/autobitch.sh"
    auto_log_prefix "$(expand_path "$1")"
}
```

Then actual calls should happen in the individual .envrc at each location:

```bash
use_auto "$1" # include script
use_auto_ruby "$1" # enable autobitching for ruby
use_auto_python "$1" # enable autobitching for python
test -d 'bin' && PATH_add 'bin' # add local executables to PATH (binstubs, virtualenv, ..)
```

> The argument of `$1` is passed to pass the _context_ (the directory containing the `.envrc` file) to the methods called. Otherwise, `direnv` would have the current working directory set to the location of the `.direnvrc` file.

### Manually

Clone this repository or get the file somehow and put it somehwere like `~/autobitch.sh`.

Include the file in your `~/.direnvrc`:

```bash
use_auto() {
    source_env "$HOME/autobitch.sh"
    auto_log_prefix "$(expand_path "$1")"
}
```

Please see above on how to put the script in use in the `.envrc` files.

### Usage

> TODO
