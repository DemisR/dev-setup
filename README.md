dev-setup
============
## Motivation

Setting up a new developer machine can be an **ad-hoc, manual, and time-consuming** process.  `dev-setup` aims to **simplify** the process with **easy-to-understand instructions** and **dotfiles/scripts** to **automate the setup** of the following:

* **OS X updates and Xcode Command Line Tools**
* **OS X defaults** geared towards developers
* **Developer tools**: Vim, bash, tab completion, curl, git, Python, etc
* **Developer apps**: iTerm2, Atom, VirtualBox, Vagrant, Docker, Chrome, IntelliJ IDEA,etc

### But...I Don't Need All These Tools!

**`dev-setup` is geared to be more of an organized *reference* of various developer tools.**

**You're *not* meant to install everything.**

If you're interested in automation, `dev-setup` provides a customizable [setup script](#single-setup-script).  There's really no one-size-fits-all solution for developers so you're encouraged to make tweaks to suit your needs.

[Credits](#credits): This repo builds on the awesome work from [Mathias Bynens](https://github.com/mathiasbynens) and [Nicolas Hery](https://github.com/nicolashery).

### For Automation, What About Vagrant, Docker, or Boxen?

[Vagrant](#vagrant) and [Docker](#docker) are great tools and are set up by this repo. I've found that Vagrant works well to ensure dev matches up with test and production tiers. I've only started playing around with Docker for side projects and it looks very promising. However, for Mac users, Docker and Vagrant both rely on **virtual machines**, which have their own considerations/pros/cons.

This repo takes a more **light-weight** approach to automation using a combination of **Homebrew, Homebrew Cask, and shell scripts** to do basic system setup.  It also provides **easy-to understand instructions** for installation, configuration, and usage for each developer app or tool.

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/iterm2.png">
</p>

### Sections Summary
* Section 1 contains the dotfiles/scripts and instructions to set up your system.
* Sections 2 through 3 detail more information about installation, configuration, and usage for topics in Section 1.

## Section 1: Installation

**Scripts tested on OS X 10.10 Yosemite.**

* [Single Setup Script](#single-setup-script)
* [bootstrap.sh script](#bootstrapsh-script)
    * Syncs dev-setup to your local home directory `~`
* [osxprep.sh script](#osxprepsh-script)
    * Updates OS X and installs Xcode command line tools
* [brew.sh script](#brewsh-script)
    * Installs common Homebrew formulae and apps
* [osx.sh script](#osxsh-script)
    * Sets up OS X defaults geared towards developers

## Section 2: General Apps and Tools

* [Atom](#atom)
* [Terminal Customization](#terminal-customization)
* [iTerm2](#iterm2)
* [Vim](#vim)
* [Git](#git)
* [VirtualBox](#virtualbox)
* [Vagrant](#vagrant)
* [Homebrew](#homebrew)
* [Python](#python)
* [Pip](#pip)
* [Virtualenv](#virtualenv)
* [Virtualenvwrapper](#virtualenvwrapper)
* [IntelliJ IDEA](#intellij-idea)

## Section 3: Misc

* [Contributions](#contributions)
* [Credits](#credits)
* [Contact Info](#contact-info)
* [License](#license)

## Section 1: Installation

### Single Setup Script

#### Running with Git

##### Clone the Repo

    $ git clone https://github.com/DemisR/dev-setup.git && cd dev-setup

##### Run the .dots Script with Command Line Arguments

**Since you probably don't want to install every section**, the `.dots` script supports command line arguments to run only specified sections.  Simply pass in the [scripts](#scripts) that you want to install.  Below are some examples.

**For more customization, you can [clone](#clone-the-repo) or [fork](https://github.com/DemisR/dev-setup/fork) the repo and tweak the `.dots` script and its associated components to suit your needs.**

Run all:

    $ ./.dots all

Run `bootstrap.sh`, `osxprep.sh`, `brew.sh`, and `osx.sh`:

    $ ./.dots bootstrap osxprep brew osx


#### Running without Git

    $ curl -O https://github.com/DemisR/dev-setup/master/.dots && ./.dots [Add ARGS Here]

#### Scripts

* [.dots](https://github.com/DemisR/dev-setup/blob/master/.dots)
    * Runs specified scripts
* [bootstrap.sh](https://github.com/DemisR/dev-setupv/blob/master/bootstrap.sh)
    * Syncs dev-setup to your local home directory `~`
* [osxprep.sh](https://github.com/DemisR/dev-setup/blob/master/osxprep.sh)
    * Updates OS X and installs Xcode command line tools
* [brew.sh](https://github.com/DemisR/dev-setup/blob/master/brew.sh)
    * Installs common Homebrew formulae and apps
* [osx.sh](https://github.com/DemisR/dev-setup/blob/master/osx.sh)
    * Sets up OS X defaults geared towards developers
* [zsh.sh](https://github.com/DemisR/dev-setup/blob/master/zsh.sh)
    * Install ZSH shell and configure iTerm2 profile

**Notes:**

* `.dots` will initially prompt you to enter your password.
* `.dots` might ask you to re-enter your password at certain stages of the installation.
* If OS X updates require a restart, simply run `.dots` again to resume where you left off.
* When installing the Xcode command line tools, a dialog box will confirm installation.
    * Once Xcode is installed, follow the instructions on the terminal to continue.
* `.dots` runs `brew.sh`, which takes awhile to complete as some formulae need to be installed from source.
* **When `.dots` completes, be sure to restart your computer for all updates to take effect.**

I encourage you to read through Section 1 so you have a better idea of what each installation script does.  The following discussions describe in greater detail what is executed when running the [.dots](https://github.com/donnemartin/dev-setup/blob/master/.dots) script.

### bootstrap.sh script

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/commands.png">
  <br/>
</p>

The `bootstrap.sh` script will sync the dev-setup repo to your local home directory.  This will include customizations for Vim, bash, curl, git, tab completion, aliases, a number of utility functions, etc.  Section 2 of this repo describes some of the customizations.

#### Running with Git

First, fork or [clone the repo](#clone-the-repo).  The `bootstrap.sh` script will pull in the latest version and copy the files to your home folder `~`:

    $ source bootstrap.sh

To update later on, just run that command again.

Alternatively, to update while avoiding the confirmation prompt:

    $ set -- -f; source bootstrap.sh

#### Running without Git

To sync dev-setup to your local home directory without Git, run the following:

    $ cd ~; curl -#L https://github.com/donnemartin/dev-setup/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,LICENSE}

To update later on, just run that command again.

#### Optional: Specify PATH

If `~/.path` exists, it will be sourced along with the other files before any feature testing (such as detecting which version of `ls` is being used takes place.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```

#### Optional: Add Custom Commands

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# Git credentials
GIT_AUTHOR_NAME="Donne Martin"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="donne.martin@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# Install or upgrade a global package
# Usage: gpip install –upgrade pip setuptools virtualenv
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
```

You could also use `~/.extra` to override settings, functions, and aliases from the dev-setup repository, although it’s probably better to [fork the dev-setup repository](https://github.com/donnemartin/dev-setup/fork).

### osxprep.sh script

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/xcode.jpg">
  <br/>
</p>

Run the `osxprep.sh` script:

    $ ./osxprep.sh

`osxprep.sh` will first install all updates.  If a restart is required, simply run the script again.  Once all updates are installed, `osxprep.sh` will then [Install Xcode Command Line Tools](#install-xcode-command-line-tools).

If you want to go the manual route, you can also install all updates by running "App Store", selecting the "Updates" icon, then updating both the OS and installed apps.

#### Install Xcode Command Line Tools

An important dependency before many tools such as Homebrew can work is the **Command Line Tools for Xcode**. These include compilers like gcc that will allow you to build from source.

If you are running **OS X 10.9 Mavericks or later**, then you can install the Xcode Command Line Tools directly from the command line with:

    $ xcode-select --install

**Note**: the `osxprep.sh` script executes this command.

Running the command above will display a dialog where you can either:
* Install Xcode and the command line tools
* Install the command line tools only
* Cancel the install

##### OS X 10.8 and Older

If you're running 10.8 or older, you'll need to go to [http://developer.apple.com/downloads](http://developer.apple.com/downloads), and sign in with your Apple ID (the same one you use for iTunes and app purchases). Unfortunately, you're greeted by a rather annoying questionnaire. All questions are required, so feel free to answer at random.

Once you reach the downloads page, search for "command line tools", and download the latest **Command Line Tools (OS X Mountain Lion) for Xcode**. Open the **.dmg** file once it's done downloading, and double-click on the **.mpkg** installer to launch the installation. When it's done, you can unmount the disk in Finder.

### brew.sh script

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/homebrew2.png">
  <br/>
</p>

When setting up a new Mac, you may want to install [Homebrew](http://brew.sh/), a package manager that simplifies installing and updating applications or libraries.

Some of the apps installed by the `brew.sh` script include: Chrome, Firefox, Sublime Text, Atom, Dropbox, Evernote, Skype, Slack, Alfred, VirtualBox, Vagrant, Docker, etc.  **For a full listing of installed formulae and apps, refer to the commented [brew.sh source file](https://github.com/donnemartin/dev-setup/blob/master/brew.sh) directly and tweak it to suit your needs.**

Run the `brew.sh` script:

    $ ./brew.sh

The `brew.sh` script takes awhile to complete, as some formulae need to be installed from source.

**For your terminal customization to take full effect, quit and re-start the terminal**

### osx.sh script

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/osx.png">
  <br/>
</p>

When setting up a new Mac, you may want to set OS X defaults geared towards developers.  The `osx.sh` script also configures common third-party apps such Sublime Text and Chrome.

**Note**: **I strongly encourage you read through the commented [osx.sh source file](https://github.com/donnemartin/dev-setup/blob/master/osx.sh) and tweak any settings based on your personal preferences.  The script defaults are intended for you to customize.**  For example, if you are not running an SSD you might want to change some of the settings listed in the SSD section.

Run the `osx.sh` script:

    $ ./osx.sh

**For your terminal customization to take full effect, quit and re-start the terminal.**

## Section 2: General Apps and Tools

### Atom

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/atom.png">
  <br/>
</p>

[Atom](https://github.com/atom/atom) is a great open-source editor from GitHub that is rapidly gaining contributors and popularity.

#### Installation

The [brew.sh script](#brewsh-script) installs Atom.

If you prefer to install it separately, [download](https://atom.io/) it, open the **.dmg** file, drag-and-drop in the **Applications** folder.

#### Configuration

Atom has a great package manager that allows you to easily install both core and community packages.

### Terminal Customization

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/terminal.png">
  <br/>
</p>

Since we spend so much time in the terminal, we should try to make it a more pleasant and colorful place.

#### Configuration

The [bootstrap.sh script](#bootstrapsh-script) and [osx.sh script](#osxsh-script) contain terminal customizations.

### iTerm2

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/iterm2.png">
  <br/>
</p>

I prefer iTerm2 over the stock Terminal, as it has some some additional [great features](https://www.iterm2.com/features.html). Download and install iTerm2 (the newest version, even if it says "beta release").

In Finder, drag and drop the iTerm Application file into the Applications folder.

You can now launch iTerm, through the Launchpad for instance.

Let's just quickly change some preferences. In iTerm > Preferences..., under the tab General, uncheck Confirm closing multiple sessions and Confirm "Quit iTerm2 (Cmd+Q)" command under the section Closing.

In the tab Profiles, create a new one with the "+" icon, and rename it to your first name for example. Then, select Other Actions... > Set as Default. Under the section Window, change the size to something better, like Columns: 125 and Rows: 35.  I also like to set General > Working Directory > Reuse previous session's directory.  Finally, I change the wy the option key works so that I can quickly jump between words as described [here](https://coderwall.com/p/h6yfda/use-and-to-jump-forwards-backwards-words-in-iterm-2-on-os-x).

When done, hit the red "X" in the upper left (saving is automatic in OS X preference panes). Close the window and open a new one to see the size change.

#### Configuration

Since we spend so much time in the terminal, we should try to make it a more pleasant and colorful place. What follows might seem like a lot of work, but trust me, it'll make the development experience so much better.

Let's go ahead and start by changing the font. In **iTerm > Preferences...**, under the tab **Profiles**, section **Text**, change both fonts to **Consolas 13pt**.

Now let's add some color. I'm a big fan of the [Solarized](http://ethanschoonover.com/solarized) color scheme. It is supposed to be scientifically optimal for the eyes. I just find it pretty.

Scroll down the page and download the latest version. Unzip the archive. In it you will find the `iterm2-colors-solarized` folder with a `README.md` file, but I will just walk you through it here:

- In **iTerm2 Preferences**, under **Profiles** and **Colors**, go to **Load Presets... > Import...**, find and open the two **.itermcolors** files we downloaded.
- Go back to **Load Presets...** and select **Solarized Dark** to activate it. Voila!

**Note**: You don't have to do this, but there is one color in the **Solarized Dark** preset I don't agree with, which is *Bright Black*. You'll notice it's too close to *Black*. So I change it to be the same as *Bright Yellow*, i.e. **R 83 G 104 B 112**.

Not a lot of colors yet. We need to tweak a little bit our Unix user's profile for that. This is done (on OS X and Linux), in the `~/.bash_profile` text file (`~` stands for the user's home directory).

We'll come back to the details of that later, but for now, just download the files [.bash_profile](https://raw.githubusercontent.com/donnemartin/dev-setup/master/.bash_profile), [.bash_prompt](https://raw.githubusercontent.com/donnemartin/dev-setup/master/.bash_prompt), [.aliases](https://raw.githubusercontent.com/donnemartin/dev-setup/master/.aliases) attached to this document into your home directory (`.bash_profile` is the one that gets loaded, I've set it up to call the others):

    $ cd ~
    $ curl -O https://raw.githubusercontent.com/donnemartin/dev-setup/master/.bash_profile
    $ curl -O https://raw.githubusercontent.com/donnemartin/dev-setup/master/.bash_prompt
    $ curl -O https://raw.githubusercontent.com/donnemartin/mac-dev-setup/master/.aliases

With that, open a new terminal tab (Cmd+T) and see the change! Try the list commands: `ls`, `ls -lh` (aliased to `ll`), `ls -lha` (aliased to `la`).

At this point you can also change your computer's name, which shows up in this terminal prompt. If you want to do so, go to **System Preferences** > **Sharing**. For example, I changed mine from "Donne's MacBook Pro" to just "MacBook Pro", so it shows up as `MacBook-Pro` in the terminal.

Now we have a terminal we can work with!

### Vim

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/vim.png">
  <br/>
</p>

Although Sublime Text will be our main editor, it is a good idea to learn some very basic usage of [Vim](http://www.vim.org/). It is a very popular text editor inside the terminal, and is usually pre-installed on any Unix system.

For example, when you run a Git commit, it will open Vim to allow you to type the commit message.

I suggest you read a tutorial on Vim. Grasping the concept of the two "modes" of the editor, **Insert** (by pressing `i`) and **Normal** (by pressing `Esc` to exit Insert mode), will be the part that feels most unnatural. After that it's just remembering a few important keys.

#### Configuration

The [bootstrap.sh script](#bootstrapsh-script) contains Vim customizations.

### VirtualBox

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/virtualbox.png">
  <br/>
</p>

VirtualBox creates and manages virtual machines.  It's a solid free solution to its commercial rival VMware.

#### Installation

The [brew.sh script](#brewsh-script) installs VirtualBox

If you prefer to install it separately, you can download it [here](https://www.virtualbox.org/wiki/Downloads) or run:

    $ brew update
    $ brew install caskroom/cask/brew-cask
    $ brew cask install --appdir="/Applications" virtualbox

### Vagrant

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/vagrant.jpeg">
  <br/>
</p>

Vagrant creates and configures development environments.  You can think of it as a higher-level wrapper around VirtualBox and configuration management tools like Ansible, Chef, Puppet, and Salt.  Vagrant also supports Docker containers and server environments like Amazon EC2.

#### Installation

The [brew.sh script](#brewsh-script) installs Vagrant.

If you prefer to install it separately, you can download it [here](https://www.vagrantup.com/) or run:

    $ brew update
    $ brew install caskroom/cask/brew-cask
    $ brew cask install --appdir="/Applications" vagrant

### Docker

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/docker.png">
  <br/>
</p>

Docker automates the deployment of applications inside software containers.  I think the following [quote](http://www.linux.com/news/enterprise/cloud-computing/731454-docker-a-shipping-container-for-linux-code) explains docker nicely: "Docker is a tool that can package an application and its dependencies in a virtual container that can run on any Linux server. This helps enable flexibility and portability on where the application can run, whether on premise, public cloud, private cloud, bare metal, etc".

#### Installation

The [brew.sh script](#brewsh-script) installs Docker.

If you prefer to install it separately, you can download it [here](https://www.docker.com/) or run:

    $ brew update
    $ brew install docker
    $ brew install boot2docker

#### Configuration

Initialize and start `boot2docker` (only need to do this once):

    $ boot2docker init

Start the VM:

    $ boot2docker up

Set the `DOCKER_HOST` environment variable and fill in IP and PORT based on the output from the `boot2coker up` command:

    $ export DOCKER_HOST=tcp://IP:PORT

### Git

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/git.png">
  <br/>
</p>

What's a developer without [Git](http://git-scm.com/)?

#### Installation

Git should have been installed when you ran through the [Install Xcode Command Line Tools](#install-xcode-command-line-tools) section.

#### Configuration

To check your version of Git, run the following command:

    $ git --version

And `$ which git` should output `/usr/local/bin/git`.

Let's set up some basic configuration. Download the [.gitconfig](https://raw.githubusercontent.com/donnemartin/dev-setup/master/.gitconfig) file to your home directory:

    $ cd ~
    $ curl -O https://raw.githubusercontent.com/donnemartin/dev-setup/master/.gitconfig

It will add some color to the `status`, `branch`, and `diff` Git commands, as well as a couple aliases. Feel free to take a look at the contents of the file, and add to it to your liking.

Next, we'll define your Git user (should be the same name and email you use for [GitHub](https://github.com/) and [Heroku](http://www.heroku.com/)):

    $ git config --global user.name "Your Name Here"
    $ git config --global user.email "your_email@youremail.com"

They will get added to your `.gitconfig` file.

To push code to your GitHub repositories, we're going to use the recommended HTTPS method (versus SSH). So you don't have to type your username and password everytime, let's enable Git password caching as described [here](https://help.github.com/articles/set-up-git):

    $ git config --global credential.helper osxkeychain

**Note**: On a Mac, it is important to remember to add `.DS_Store` (a hidden OS X system file that's put in folders) to your `.gitignore` files. You can take a look at this repository's [.gitignore](https://github.com/donnemartin/dev-setup/blob/master/.gitignore) file for inspiration.  Also check out GitHub's [collection of .gitignore templates](https://github.com/github/gitignore).

### Homebrew

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/homebrew.png">
  <br/>
</p>

Package managers make it so much easier to install and update applications (for Operating Systems) or libraries (for programming languages). The most popular one for OS X is [Homebrew](http://brew.sh/).

#### Installation

The [brew.sh script](#brewsh-script) installs Homebrew and a number of useful Homebrew formulae and apps.

If you prefer to install it separately, run the following command and follow the steps on the screen:

    $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#### Usage

To install a package (or **Formula** in Homebrew vocabulary) simply type:

    $ brew install <formula>

To update Homebrew's directory of formulae, run:

    $ brew update

**Note**: I've seen that command fail sometimes because of a bug. If that ever happens, run the following (when you have Git installed):

    $ cd /usr/local
    $ git fetch origin
    $ git reset --hard origin/master

To see if any of your packages need to be updated:

    $ brew outdated

To update a package:

    $ brew upgrade <formula>

Homebrew keeps older versions of packages installed, in case you want to roll back. That rarely is necessary, so you can do some cleanup to get rid of those old versions:

    $ brew cleanup

To see what you have installed (with their version numbers):

    $ brew list --versions

### Python

<p align="center">
  <img src="https://raw.githubusercontent.com/donnemartin/dev-setup-resources/master/res/python.png">
  <br/>
</p>

OS X, like Linux, ships with [Python](http://python.org/) already installed. But you don't want to mess with the system Python (some system tools rely on it, etc.), so we'll install our own version with Homebrew. It will also allow us to get the very latest version of Python 2.7 and Python 3.

#### Installation

The [brew.sh script](#brewsh-script) installs the latest versions of Python 2 and Python 3.

### Pip

[Pip](https://pypi.python.org/pypi/pip) is the Python package manager.

#### Installation

The [pydata.sh script](#pydatash-script) installs pip.

#### Usage

Here are a couple Pip commands to get you started. To install a Python package:

    $ pip install <package>

To upgrade a package:

    $ pip install --upgrade <package>

To see what's installed:

    $ pip freeze

To uninstall a package:

    $ pip uninstall <package>

### Virtualenv

[Virtualenv](http://www.virtualenv.org/) is a tool that creates an isolated Python environment for each of your projects. For a particular project, instead of installing required packages globally, it is best to install them in an isolated folder in the project (say a folder named `venv`), that will be managed by virtualenv.

The advantage is that different projects might require different versions of packages, and it would be hard to manage that if you install packages globally. It also allows you to keep your global `/usr/local/lib/python2.7/site-packages` folder clean.

#### Usage

Let's say you have a project in a directory called `myproject`. To set up virtualenv for that project:

    $ cd myproject/
    $ virtualenv venv --distribute

If you want your virtualenv to also inherit globally installed packages (like IPython or Numpy mentioned above), use:

    $ virtualenv venv --distribute --system-site-packages

These commands create a `venv` subdirectory in your project where everything is installed. You need to **activate** it first though (in every terminal where you are working on your project):

    $ source venv/bin/activate

You should see a `(venv)` appear at the beginning of your terminal prompt indicating that you are working inside the virtualenv. Now when you install something:

    $ pip install <package>

It will get installed in the `venv` folder, and not conflict with other projects.

**Important**: Remember to add `venv` to your project's `.gitignore` file so you don't include all of that in your source code!

### Virtualenvwrapper

[Virtualenvwrapper](https://virtualenvwrapper.readthedocs.org/en/latest/) is a set of extensions that includes wrappers for creating and deleting virtual environments and otherwise managing your development workflow, making it easier to work on more than one project at a time without introducing conflicts in their dependencies.

Main features include:

* Organizes all of your virtual environments in one place.
* Wrappers for managing your virtual environments (create, delete, copy).
* Use a single command to switch between environments.
* Tab completion for commands that take a virtual environment as argument.

#### Usage

Create a new virtual environment. When you create a new environment it automatically becomes the active environment:

    $ mkvirtualenv [env name]

Remove an existing virtual environment. The environment must be deactivated (see below) before it can be removed:

    $ rmvirtualenv [env name]

Activate a virtual environment. Will also list all existing virtual environments if no argument is passed:

    $ workon [env name]

Deactivate the currently active virtual environment. Note that workonwill automatically deactivate the current environment before activating a new one:

    $ deactivate

## Section 4: Misc

### Contributions

Bug reports, suggestions, and pull requests are [welcome](https://github.com/donnemartin/dev-setup/issues)!

### Credits

See the [Credits Page](https://github.com/donnemartin/dev-setup/blob/master/CREDITS.md).

## Contact Info

Feel free to contact me to discuss any issues, questions, or comments.

* Email: [donne.martin@gmail.com](mailto:donne.martin@gmail.com)
* Twitter: [@donne_martin](https://twitter.com/donne_martin)
* GitHub: [donnemartin](https://github.com/donnemartin)
* LinkedIn: [donnemartin](https://www.linkedin.com/in/donnemartin)
* Website: [donnemartin.com](http://donnemartin.com)

### License

This repository contains a variety of content; some developed by Donne Martin, and some from third-parties.  The third-party content is distributed under the license provided by those parties.

The content developed by Donne Martin is distributed under the following license:

    Copyright 2015 Donne Martin

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
