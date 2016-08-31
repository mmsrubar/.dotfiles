#!/bin/bash

#trap read debug

ROOT=$HOME/.dotfiles
BACKUP=$ROOT/backup

dotfiles=(.config/xfce4/terminal/{accels.scm,terminalrc} .gitconfig .dircolors \
  .bashrc .powerline-shell.py .vimrc .ghci .haskeline .git-completion.bash \
  .themes .fonts .vim)

# Create backup dir if there is not one yet
if [ ! -d $BACKUP ]; then
  echo "> mkdir $BACKUP"
  mkdir $BACKUP
fi

# $1 is file that will be backed up
backup() {
  if [ -h $HOME/$1 ];
  then
    # If a dotfile is already a symlink to somewhere then backup it up and then
    # unlink it
    echo "> backup ~/$1"
    cp "$HOME/$1" "$BACKUP" 2> /dev/null
    echo "> unlink ~/$1"
    unlink $HOME/$1 2> /dev/null
    return
  elif [ -d $HOME/$1 ];
  then
    rm -rf $BACKUP/$1 # remove old backup directory
  fi

  echo "> backup ~/$1"
  mv "$HOME/$1" "$BACKUP" 2> /dev/null
}

# $1 is file which will be linked to $ROOT/$1
link() {
  if [[ ! -d $HOME/`dirname $1` ]]; then
    echo "> created the dir $HOME/`dirname $1` first"
    mkdir $HOME/`dirname $1`
  fi
  echo "> link   ~/$1 --> $ROOT/$1"
  ln -s "$ROOT/$1" "$HOME/$1"
}

command -v dialog >/dev/null 2>&1 || { echo >&2 "I require dialog but it's not installed.  Aborting."; exit 1; }

# get the list of dotfiles to a single string for the dialog utility
counter=1
for f in ${dotfiles[@]}; do
  list="$list $counter \"$f\" \"off\""
  let counter=counter+1
done
#echo "List: $list"

# show the dialog for user so he can select what dotfiles he wants to link
results=`mktemp`
dialog --title "Link my dotfiles" --checklist "Select desired dotfiles" 20 55 ${#dotfiles[*]} $list 2> $results


for i in $(cat $results); do
  backup "${dotfiles[$((i-1))]}"
  link "${dotfiles[$((i-1))]}"

  if [ "${dotfiles[$((i-1))]}" = ".fonts" ]; then
    (cd $HOME/.fonts; sh install.sh) # fonts has to be installed
  fi
done

rm $results
