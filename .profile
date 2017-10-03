# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
PATH="$HOME/.cabal/bin:$PATH"
# adding ruby gem to path
export PATH="/home/kwon-young/.gem/ruby/2.3.0/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

setaw() {
  echo $(setxkbmap -query)
  IN=$(setxkbmap -query | grep options | sed "s/options:\s\+\(.*\)/\1/")

  setxkbmap -option ""

  FOUND=false
  for i in $(echo $IN | tr "," "\n"); do
    echo $(setxkbmap -query)
    echo "$i"
    if echo "$i" | grep "altwin:swap_lalt_lwin"
    then
      FOUND=true
    else
      setxkbmap -option "$i"
    fi
  done
  if lsusb -d 430:5
  then
    setxkbmap -option "altwin:swap_lalt_lwin"
  fi
  echo $(setxkbmap -query)
}
