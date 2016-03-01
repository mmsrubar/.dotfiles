#!/bin/sh

#set -x
#trap read debug

ROOT=$HOME/.dotfiles
BACKUP=$ROOT/backup

dotfiles=(.config/xfce4/terminal/{accels.scm,terminalrc} .gitconfig .dircolors \
  .bashrc .powerline-shell.py .vimrc .ghci .haskeline .git-completion.bash)
dotdirs=(.themes .fonts .vim)

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
    echo "> backup $1"
    cp "$HOME/$1" "$BACKUP" 2> /dev/null
    echo "> unlink $1"
    unlink $HOME/$1 2> /dev/null
    return
  elif [ -d $HOME/$1 ];
  then
    rm -rf $BACKUP/$1 # remove old backup directory
  fi

  echo "> backup $HOME/$1"
  mv "$HOME/$1" "$BACKUP" 2> /dev/null
}

# $1 is file which will be linked to $ROOT/$1
link() {
  echo "> link   $1 --> $ROOT/$1"
  ln -s "$ROOT/$1" "$HOME/$1"
}

for f in ${dotfiles[@]} ${dotdirs[@]}; do
  backup "$f"
  link "$f"
done

(cd $HOME/.fonts; sh install.sh) # fonts has to be installed
