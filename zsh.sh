##!/usr/bin/env bash

## Ask for the administrator password upfront.
sudo -v

## Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

read -p "This script install ZSH in remplaceemnt of Bash shell. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Install zsh
  brew install zsh zsh-completions
  cp ./Inconsolata\ for\ Powerline.otf /Library/Fonts/
  cp ./com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
  # download and install Oh-my-zsh
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

fi;
