# sourced in login shells
# TODO: like .interactive, consider creating a common .login startup script

[[ -f ~/.profile ]] && source ~/.profile

# we don't need to source .zshrc here as we do for .bashrc, because zsh always loads it (after .zprofile)
# https://zsh.sourceforge.io/Intro/intro_3.html

zprofile_loaded=$$

# Created by `pipx` on 2024-05-15 22:16:51
export PATH="$PATH:/Users/davidnutting/.local/bin"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
