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
# bindkey "\e[H" beginning-of-line
# bindkey "\e[F" end-of-line
# bindkey '^X' create_completion
# zle -N create_completion
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

export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en
export LC_CTYPE=zh_CN.UTF-8
export LC_NUMERIC=zh_CN.UTF-8
export LC_TIME=zh_CN.UTF-8
export LC_COLLATE=zh_CN.UTF-8
export LC_MONETARY=zh_CN.UTF-8
export LC_MESSAGES=zh_CN.UTF-8
export LC_PAPER=zh_CN.UTF-8
export LC_NAME=zh_CN.UTF-8
export LC_ADDRESS=zh_CN.UTF-8
export LC_TELEPHONE=zh_CN.UTF-8
export LC_MEASUREMENT=zh_CN.UTF-8
export LC_IDENTIFICATION=zh_CN.UTF-8

setopt no_nomatch

scp_fetch() {
    if [ $# -ne 2 ]; then
        echo "Usage: scp_fetch <IP_ADDRESS> <REMOTE_RELATIVE_PATH>"
        return 1
    fi

    local IP="$1"
    local REMOTE_PATH="$2"
    local SRC_PATH="speed@${IP}:~/speedzjy/rl_venv/ws/fjspb-drl/data/${REMOTE_PATH}/"
    local DEST_PATH="/data/cls1-srv2-pool/speed/rl_venv/ws/fjspb-drl/data/${REMOTE_PATH}/"

    echo "📥 Copying files from ${SRC_PATH} to ${DEST_PATH}..."
    scp -r "${SRC_PATH}" "${DEST_PATH}"

    if [ $? -eq 0 ]; then
        echo "✅ Copy completed successfully!"
    else
        echo "❌ Copy failed. Check your connection and paths."
    fi
}

scp_push() {
    if [ $# -ne 2 ]; then
        echo "Usage: scp_push <IP_ADDRESS> <REMOTE_RELATIVE_PATH>"
        return 1
    fi

    local IP="$1"
    local REMOTE_PATH="$2"
    local SRC_PATH="/data/cls1-srv2-pool/speed/rl_venv/ws/fjspb-drl/data/${REMOTE_PATH}/"
    local DEST_PATH="speed@${IP}:~/speedzjy/rl_venv/ws/fjspb-drl/data/${REMOTE_PATH}/"

    echo "📤 Copying files from ${SRC_PATH} to ${DEST_PATH}..."
    scp -r "${SRC_PATH}" "${DEST_PATH}"

    if [ $? -eq 0 ]; then
        echo "✅ Copy completed successfully!"
    else
        echo "❌ Copy failed. Check your connection and paths."
    fi
}



export PATH=$PATH:/data/cls1-srv2-pool/cplex/cplex/bin/x86-64_linux:/data/cls1-srv2-pool/cplex/cpoptimizer/bin/x86-64_linux
alias fjspb="cd /data/cls1-srv2-pool/speed/rl_venv && source ./bin/activate && cd ws/fjspb-drl"