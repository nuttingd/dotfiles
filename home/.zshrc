# sourced in interactive shells
# if not running interactively, short circuit
[ -z "$PS1" ] && return

# Enable Powerlevel10k instant prompt. Should stay close to the top of $HOME/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
p10k_instant_prompt_path="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
[[ -f "$p10k_instant_prompt_path" ]] && source $p10k_instant_prompt_path

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
    fzf
    nomad
    kubectl
    docker
    docker-compose
    minikube
    tmux-vim-integration
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-vim-mode)
[[ -d "$ZSH" ]] && source $ZSH/oh-my-zsh.sh
# Source common interactive shell magic (put this after oh-my-zsh)
if [[ -f "$HOME/.interactive" ]]; then
    source $HOME/.interactive
else
    echo 'Could not find $HOME/.interactive. Do you need to recreate symlinks?'
fi

# colors
export LSCOLORS= # I don't like the defaults set by ~/.oh-my-zsh/lib/theme-and-appearance.zsh
command -v vivid &> /dev/null && export LS_COLORS="$(vivid generate ayu)"

# AWS autocompletions
command -v aws_completer &> /dev/null && complete -C 'aws_completer' aws

# bash completions support for ZSH
autoload bashcompinit && bashcompinit
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

# To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
p10k_path="$HOME/.p10k.zsh"
[[ -f "$p10k_path" ]] && source $p10k_path

zshrc_loaded=$$
export PATH="$HOME/.local/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/davidnutting/.lmstudio/bin"
# End of LM Studio CLI section


# opencode
export PATH=/Users/davidnutting/.opencode/bin:$PATH

# bun completions
[ -s "/Users/davidnutting/.bun/_bun" ] && source "/Users/davidnutting/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
