#!/bin/sh

ROOT=$HOME/.new-dotfiles
BACKUP=$ROOT/backup
DOTDIRS=(.fonts)

# Create backup dir if there is not one yet
if [ ! -d $BACKUP ]; then
  echo "> Creating dir $BACKUP"
  mkdir $BACKUP
fi

# $1 file or dir that will be backed up
backup() {
  echo "backup() $1"
  if [ -h $HOME/$1 ];
  then
    echo "> $HOME/$1 already is a symbolic link"
    exit 1
  elif [ -f $HOME/$1 ] || [ -d $HOME/$1 ];
  then
    echo "> Backing up file/dir $HOME/$1 into $BACKUP"
    mv "$HOME/$1" "$BACKUP" 2> /dev/null
  fi
}

# $1 file or dir which will be linked to $ROOT/$1
link() {
  echo "> Linking file $HOME/$1 into $ROOT/$1"
  ln -s "$ROOT/$1" "$HOME/$1"
}

# Install new fonts
echo -n "Do you want to install new fonts? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *) backup ".fonts"; 
    link ".fonts"; 
    (cd $HOME/.fonts; sh install.sh) ;; #install
esac

# XFCE Terminal configuration
echo -n "Do you want to set your xfce terminal settings? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *) backup ".config/xfce4/terminal"; 
    link ".config/xfce4/terminal" ;;
esac

# GIT config
echo -n "Do you want to copy .gitconfig? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *) backup ".gitconfig"; 
    link ".gitconfig" ;;
esac

# Bash settings
echo -n "Link bash settings (.dircolors, .bashrc, ...)? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *) backup ".dircolors"; backup ".bashrc"; backup ".powerline-shell.py";
    link ".dircolors"; link ".bashrc"; link ".powerline-shell.py" ;;
esac

# Bash settings
echo -n "Link vim settings (.vimrc, .vim/)? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *) backup ".vimrc"; backup ".vim"
    link ".vimrc"; link ".vim" ;;
esac
