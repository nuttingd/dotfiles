# sourced in login shells
# TODO: like .interactive, consider creating a common .login startup script

[[ -f ~/.profile ]] && source ~/.profile

# we don't need to source .zshrc here as we do for .bashrc, because zsh always loads it (after .zprofile)
# https://zsh.sourceforge.io/Intro/intro_3.html

zprofile_loaded=$$
