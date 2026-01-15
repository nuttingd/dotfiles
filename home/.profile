# ~/.profile: executed by the command interpreter for login shells.
# Sourced by all shells, sometimes automatically (bash), sometimes by force (zsh)

# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.  Note, however, that we will have a ~/.bash_profile and it
# will simply source this file as a matter of course.

# See /usr/share/doc/bash/examples/startup-files for examples.
# The files are located in the bash-doc package.

source $HOME/.environment

if command -v gpgconf &>/dev/null; then
    gpgconf --launch gpg-agent
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi

profile_loaded=$$

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/davidnutting/.lmstudio/bin"
# End of LM Studio CLI section

