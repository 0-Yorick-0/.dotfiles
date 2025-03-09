# What is it ?

My personnal config for my environment :

- zsh
- tmux
- vim
- git

## How to use it ?

Easy !

`git clone --recurse-submodules git@gitlab.com:0-Yorick-0/dotfiles.git`

Just go to your office, open your laptop, start your linux session and run `install.sh` to get all of your environment configured like home.

## How to update an existent repo with submodule :

- `rm -rf <existent_sub_modules>`
- `git submodule update --init`
- `git submodule update --recursive`

## Help :

### Plugins :

#### Mundo :

Si erreur :`Plugin MundoToggle : Python not supported`
--> run pip install pynvim'

#### Devicons :

Sur Mac :

- `brew tap homebrew/cask-fonts`
- `brew install --cask font-hack-nerd-font`
- set la font du terminal sur `Hack Nerd Font`

#### Install Fzf :

Sur Mac :

- `$(brew --prefix)/opt/fzf/install`
- `mv ~/fzf.zsh $DOTFILES/zsh/config/3_fzf.zsh`

#### Install apcu

see https://stackoverflow.com/questions/72039019/pcre2-h-no-such-file-or-directory

#### Install PHP DAP
* go to $VIMCONFIG/share/nvim/lazy/vs-code-php-debug
* launch `npm install && npm run build`

#### TMUX

* /!\ DON'T FORGET TO INSTALL TPM PLUGINS
* RUN TMUX AND PRESS `PREFIX + I` TO INSTALL PLUGINS
