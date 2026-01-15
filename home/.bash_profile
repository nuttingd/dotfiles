# ~/.bash_profile: executed by the command interpreter for login shells.

# Because of this file's existence, neither ~/.bash_login nor ~/.profile
# will be sourced.

# See /usr/share/doc/bash/examples/startup-files for examples.
# The files are located in the bash-doc package.

# Because ~/.profile isn't invoked if this files exists,
# we must source ~/.profile to get its settings:
[[ -f "$HOME/.profile" ]] && source $HOME/.profile

# The following sources ~/.bashrc in the interactive login case,
# because .bashrc isn't sourced for interactive login shells:
[[ -f "$HOME/.bashrc" ]] && source $HOME/.bashrc

bash_profile_loaded=$$

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/davidnutting/.lmstudio/bin"
# End of LM Studio CLI section

