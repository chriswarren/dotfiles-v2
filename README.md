## dotfiles

Simple environment for working as web developer

### What's included

This environment helps with working with these tools/languages:

- zsh/oh-my-zsh
- git
- neovim
- tmux
- Ruby/Rails
- Javascript/React/TS

Other utility tools include:

- [asdf](https://github.com/asdf-vm/asdf) -- manages languages (replaces rvm, nvm)
- [autojump](https://github.com/wting/autojump) -- easily jump to directories
- [fzf](https://github.com/junegunn/fzf) -- fuzzy finder for the terminal

### Installation

- clone the repo anywhere in your system
- run `make`

### Make it your own

Place your customizations into a `.local` file and the original dotfile will source your
custom file.

For example:

`.zshrc.local` will be sourced by `zhsrc` \
`.tmux.conf.local` will be sourced by `.tmux.conf`

The entry point is the `Makefile` and custom tools can be included via homebrew in
the `Brewfile`

### Uninstall

- run `bin/uninstall`

### Future improvements

- automatically set iterm font to hacknerd font
- installing oh-my-zsh should not stall the make step
- automate Karabiner installation/settings to map caps-lock to ctrl/esc

### Trouble shooting

If you don't have `oh-my-zsh` installed, you will have to run `make` again \
after it installs in shell make step. 

Inspiration came from ## athal7's dotfiles
