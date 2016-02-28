#!/bin/sh

ROOT=$HOME/.dotfiles
BACKUP=$ROOT/backup
DOTDIRS=(.fonts)

dotfiles=(.fonts .config/xfce4/terminal .gitconfig .dircolors .bashrc \
  .powerline-shell.py .vimrc .vim .ghci .haskeline)

# Create backup dir if there is not one yet
if [ ! -d $BACKUP ]; then
  echo "> Creating dir $BACKUP"
  mkdir $BACKUP
fi

# TODO: use getopt() and put this under -u option
# Unlink the files first
#for file in ${dotfiles[@]}; do
#  echo "> unlinking $HOME/$file"
#  unlink $HOME/$file 2> /dev/null
#done

un_link() {
  echo "> unlinking $HOME/$1"
  unlink $HOME/$1 2> /dev/null
}

# $1 file or dir that will be backed up
backup() {
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
  echo "> Linking file $HOME/$1 into $1"
  ln -s "$ROOT/$1" "$HOME/$1"
}

# Install new fonts
echo -n "Do you want to install new fonts? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *)un_link ".fonts";
    backup ".fonts"; 
    link ".fonts"; 
    (cd $HOME/.fonts; sh install.sh) ;; #install
esac

# XFCE Terminal configuration
echo -n "Do you want to set your xfce terminal settings? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *)un_link ".config/xfce4/terminal";
    backup ".config/xfce4/terminal"; 
    link ".config/xfce4/terminal" ;;
esac

# GIT config
echo -n "Do you want to copy .gitconfig? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *)un_link ".gitconfig";
    backup ".gitconfig"; 
    link ".gitconfig" ;;
esac

# Bash settings
echo -n "Link bash settings (.dircolors, .bashrc, ...)? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *)un_link ".dircolors"; un_link ".bashrc"; un_link ".powerline-shell.py";
    backup ".dircolors"; backup ".bashrc"; backup ".powerline-shell.py";
    link ".dircolors"; link ".bashrc"; link ".powerline-shell.py" ;;
esac

# Bash settings
echo -n "Link vim settings (.vimrc, .vim/)? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *)un_link ".vimrc"; un_link ".vim"
    backup ".vimrc"; backup ".vim"
    link ".vimrc"; link ".vim" ;;
esac

# Haskell settings
echo -n "Link Haskell settings? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *) un_link ".ghci"; un_link "..haskeline"
    backup ".ghci"; backup "..haskeline"
    link ".ghci"; link ".haskeline" ;;
esac

# New XFCE themes
echo -n "Link new XFCE themes? [y/n] (Default: y): "
read answer
case "$answer" in 
  n | no | No | No) ;; # do nothing
  *) un_link ".themes"; backup ".themes"; link ".themes" ;;
esac
