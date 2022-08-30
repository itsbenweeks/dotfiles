.dotfiles
---------

This is where my personal dotfiles are kept. 

## Installation
To begin installation, clone this project into a `.dotfiles` directory:

```sh
~ git clone git@github.com:itsbenweeks/dotfiles.git .dotfiles
```

To install use GNU `stow`.

### Install GNU `stow`

#### With homebrew

There is a brewfile included in this directory, which installs a number of useful GNU tools --including `stow`. This means you can install all the files when in the dotfiles directory.

```sh
cd ~/.dotfiles
brew bundle
```

### Run `stow` command

Now that `stow` is installed, perform an installation with the following command:

```sh
stow --dotfiles .
```

With that, dotfiles will now be symlinked into the appropriate location!
