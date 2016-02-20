##!/usr/bin/env bash

## Install command-line tools using Homebrew.

## Ask for the administrator password upfront.
sudo -v

## Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

## Check for Homebrew,
## Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

## Make sure we’re using the latest Homebrew.
brew update

## Upgrade any already-installed formulae.
brew upgrade --all

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi

## Install `wget` with IRI support.
brew install wget --with-iri

###############################################################################
# Python                                                                      #
###############################################################################
## Install Python
brew install python
brew install python3

# Install pip
easy_install pip

# Install virtual environments globally
pip install virtualenv
pip install virtualenvwrapper

echo "------------------------------"
echo "Source virtualenvwrapper from ~/.extra"

EXTRA_PATH=~/.extra
echo $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "# Source virtualenvwrapper, added by pydata.sh" >> $EXTRA_PATH
echo "export WORKON_HOME=~/.virtualenvs" >> $EXTRA_PATH
echo "source /usr/local/bin/virtualenvwrapper.sh" >> $EXTRA_PATH
echo "" >> $BASH_PROFILE_PATH
source $EXTRA_PATH
###############################################################################

## Install other useful binaries.
#brew install dark-mode
brew install git
brew install git-lfs
brew install git-flow
brew install git-extras
brew install ssh-copy-id
brew install tree
brew install nmap
brew install httpie
brew install csshx
brew install whatmask

## Install universal document converter
brew install pandoc

## Install Cask
brew install caskroom/cask/brew-cask

## Core casks
brew cask install --appdir="/Applications" iterm2
#brew cask install --appdir="/Applications" java

## Development tool casks
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" vagrant
brew cask install --appdir="/Applications" vagrant-manager
brew cask install --appdir="/Applications" sourcetree
brew cask install --appdir="/Applications" macdown

## Install Atom code editor
brew cask install --appdir="/Applications" atom
## Install Atom plugins
echo "Use this commands tu install most useful Atom plugins:

apm install atom-beautify
apm install block-comment
apm install ever-notedown
apm install file-icons
apm install git-history
apm install git-log
apm install language-generic-config
apm install language-nagios
apm install linter
apm install linter-pylama
apm install linter-shellcheck
apm install merge-conflicts
apm install open-recent
apm install markdown-writer
"

## Misc casks
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" skype
#brew cask install --appdir="/Applications" slack
sudo softwareupdate --install slack
brew cask install --appdir="/Applications" evernote

## Install Docker, which requires virtualbox
#brew install docker
#brew install boot2docker

# Othe Applications
brew cask install --appdir="/Applications" remote-desktop-connectio
#brew cask install --appdir="/Applications" 1password
#sudo softwareupdate --install 1password
brew cask install --appdir="/Applications" vlc
brew cask install --appdir="/Applications" transmission
brew cask install --appdir="/Applications" caffeine
#sudo softwareupdate --install caffeine
#brew cask install --appdir="/Applications" valentina-studio
brew cask install --appdir="/Applications" cheatsheet
brew cask install --appdir="/Applications" filezilla
brew cask install --appdir="/Applications" microsoft-office

## Dev
brew cask install --appdir="/Applications" sourcetree
brew cask install --appdir="/Applications" intellij-idea

## Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

## Remove outdated versions from the cellar.
brew cleanup
