# What is it ?

My personnal config for my environment :

* zsh
* tmux
* vim
* git

## How to use it ?

Easy ! 

`git clone --recurse-submodules git@gitlab.com:0-Yorick-0/dotfiles.git`

Just go to your office, open your laptop, start your linux session and run `install.sh` to get all of your environment configured like home.

## Help :

### Plugins :

#### Mundo :

Si erreur :`Plugin MundoToggle : Python not supported`
--> run pip install pynvim'

#### Devicons :

Sur Mac : 
* `brew tap homebrew/cask-fonts`
* `brew install --cask font-hack-nerd-font`
* set la font du terminal sur `Hack Nerd Font`

#### Install Fzf :

Sur Mac :
* `$(brew --prefix)/opt/fzf/install`
* `mv ~/fzf.zsh $DOTFILES/zsh/config/3_fzf.zsh`
