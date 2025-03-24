# omz:
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
ZSH_THEME="ys"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
zstyle ':omz:update' mode auto
source $ZSH/oh-my-zsh.sh

# zsh:
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey '^X' create_completion
zle -N create_completion
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt EXTENDED_HISTORY

# proxy:
alias SET_PROXY="export http_proxy=\"http://proxy.lab.tiankaima.cn:7890\" https_proxy=\$http_proxy no_proxy=\"localhost, 127.0.0.1, ::1, *.cn\""
alias UNSET_PROXY="unset http_proxy https_proxy no_proxy"

# if [[ $- =~ i ]] && [[ -z "$TMUX" ]]; then
#     tmux attach-session -t main || tmux new-session -s main
# fi

export PATH=$PATH:/data/cls1-srv2-pool/cplex/cplex/bin/x86-64_linux:/data/cls1-srv2-pool/cplex/cpoptimizer/bin/x86-64_linux
alias fjspb="cd /data/cls1-srv2-pool/speed/rl_venv && source ./bin/activate && cd ws/"