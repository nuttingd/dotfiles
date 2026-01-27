# ~/.bashrc: executed by bash(1) for interactive non-login shells and some non-interactive remote shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples
# https://unix.stackexchange.com/questions/257571/why-does-bashrc-check-whether-the-current-shell-is-interactive

# If not running interactively, stop here
[ -z "$PS1" ] && return

# Source common interactive shell magic
[[ -f "$HOME/.interactive" ]] && source "$HOME"/.interactive

# Put bash-specific interactive shell config below ---------------

# enable bash completions
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && source /usr/local/etc/profile.d/bash_completion.sh

bashrc_loaded=$$

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/davidnutting/.lmstudio/bin"
# End of LM Studio CLI section

# Shell completion configuration for the Click Python package
command -v mon >/dev/null 2>&1 && eval "$(_MON_COMPLETE=bash_source mon)"
