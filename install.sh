#!/usr/bin/env bash

################
### includes ###
################

source ./colors.sh
source ./zsh/.zshenv

echo -e " 
${red}

     _                      _______                      _
  _dMMMb._              .adOOOOOOOOOba.              _,dMMMb_
 dP'  ~YMMb            dOOOOOOOOOOOOOOOb            aMMP~  'Yb
 V      ~'Mb          dOOOOOOOOOOOOOOOOOb          dM'~      V
          'Mb.       dOOOOOOOOOOOOOOOOOOOb       ,dM'
           'YMb._   |OOOOOOOOOOOOOOOOOOOOO|   _,dMP'
      __     'YMMM| OP'~'YOOOOOOOOOOOP'~'YO |MMMP'     __
    ,dMMMb.     ~~' OO     'YOOOOOP'     OO '~~     ,dMMMb.
 _,dP~  'YMba_      OOb      'OOO'      dOO      _aMMP'  ~Yb._

             'YMMMM\'OOOo     OOO     oOOO'/MMMMP'
     ,aa.     '~YMMb 'OOOb._,dOOOb._,dOOO'dMMP~'       ,aa.
   ,dMYYMba._         'OOOOOOOOOOOOOOOOO'          _,adMYYMb.
  ,MP'   'YMMba._      OOOOOOOOOOOOOOOOO       _,adMMP'   'YM.
  MP'        ~YMMMba._ YOOOOPVVVVVYOOOOP  _,adMMMMP~       'YM
  YMb           ~YMMMM\'OOOOI'''''IOOOOO'/MMMMP~           dMP
   'Mb.           'YMMMb'OOOI,,,,,IOOOO'dMMMP'           ,dM'
     ''                  'OObNNNNNdOO'                   ''
                           '~OOOOO~'   

"

echo -e "${green}All right, you're installing you're fuckin' damn' favorite config that'll make you rock !!\n${green}" \
	"${green}Are you ready ?${green}"

if [ $# -ne 1 ] || [ "$1" != "-y" ]; then
	echo -e "${yellow}Press a key to continue...\n"
	read key
fi

###############
### install ###
###############

source "$DOTFILES/install/install-brew.sh"
source "$DOTFILES/install/install-zsh.sh"
source "$DOTFILES/install/install-tmux.sh"
source "$DOTFILES/install/install-git.sh"
source "$DOTFILES/install/install-vim.sh"
source "$DOTFILES/install/install-mycli.sh"
source "$DOTFILES/install/install-psysh.sh"
