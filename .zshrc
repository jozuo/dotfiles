# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# alias
#alias ls="ls -GF"
alias ls="lsd"
alias gls="gls --color"
# alias tig='TERM=xterm-256color tig'
alias awslocal="aws --endpoint-url=http://localhost:8000"
alias pytest="python -m pytest -v -s --disable-warnings"
alias vi="nvim"
alias vim="nvim"
alias vimdiff='nvim -d '

if [ `uname -s` = "Darwin" ]; then
  alias awk='gawk'
  alias sed='gsed'
  alias tar='gtar'
fi

# editor
export EDITOR=nvim
export VISUAL=nvim

# history
setopt HIST_IGNORE_DUPS           # 前と重複する行は記録しない
setopt HIST_IGNORE_ALL_DUPS       # 履歴中の重複行をファイル記録前に無くす
setopt HIST_IGNORE_SPACE          # 行頭がスペースのコマンドは記録しない
setopt HIST_FIND_NO_DUPS          # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_REDUCE_BLANKS         # 余分な空白は詰めて記録
setopt HIST_NO_STORE              # histroyコマンドは記録しない

# zsh - fish like
set -o vi
bindkey -v
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi
if [ -e ~/.zsh/completions ]; then
  fpath=(~/.zsh/completions $fpath)
fi
autoload -Uz compinit && compinit

setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_list
setopt auto_menu
setopt share_history              # zsh間でhistoryを共有
setopt auto_cd                    # cd無しでディレクトリ移動
setopt extended_glob              # 高機能なワイルドカード展開を使用する
setopt correct                    # コマンドのスペルミスを指摘

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ":completion:*:commands" rehash 1
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'
# zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# zstyle ":completion:*:commands" rehash 1
# zstyle ':completion:*' menu select
# zstyle ':completion:*:default' menu select=1
# zstyle ':completion:*:cd:*' ignore-parents parent pwd
# zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'

# original script
if [ -d $HOME/.bin/ ]; then
  export PATH="$HOME/.bin:$PATH"
fi

# direnv
eval "$(direnv hook zsh)"

# git
alias g='git'
alias gsw='git switch $(git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'
export PATH=${PATH}:/usr/local/share/git-core/contrib/diff-highlight

# fasd
eval "$(fasd --init auto)"
alias v='f -e vim'
alias o='f -e open'

# java - jenv
if [ -d $HOME/.jenv/ ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

# node - nodenv
if [ -d $HOME/.nodenv/ ]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

# python - pyenv
if [ -d $HOME/.pyenv/ ]; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init --path)"
fi
# python - poetry
if [ -d $HOME/.poetry/ ]; then
  export PATH=$HOME/.poetry/bin:${PATH}
fi

# php - composer
if [ -d $HOME/.composer/vendor ]; then
  export PATH=$HOME/.composer/vendor/bin:${PATH}
fi

# yarn
if [ -d $HOME/.yarn/ ]; then
  export PATH="$PATH:${HOME}/.yarn/bin"
fi

# cargo
if [ -d $HOME/.cargo/ ]; then
  export PATH=$PATH:"$HOME/.cargo/bin"
fi

# mysql-client
if [ -d $HOMEBREW_PREFIX/opt/mysql-client/ ]; then
  export PATH=$HOMEBREW_PREFIX/opt/mysql-client/bin:$PATH
fi

# fzf
if [ -f ~/.fzf.zsh ]; then 
  source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='ag -g ""'
  export FZF_COMPLETION_TRIGGER="?" # default: '**'
  export FZF_DEFAULT_OPTS='--height 40% --reverse --border --color fg:242,bg:233,hl:65,fg+:15,bg+:234,hl+:108 --color info:108,prompt:109,spinner:108,pointer:168,marker:168'
  # --preview "[[ $(file --mime {}) =~ binary  ]] && echo {} is a binary file || (highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -500"
fi

if [ -f $HOME/.zsh/docker/docker-fzf.zsh ]; then
  source ${HOME}/.zsh/docker/docker-fzf.zsh
fi

function fzf-docker_exec () {
    local selected_file=$(docker ps --format "{{.Names}}" | fzf)
    if [ -n "$selected_file" ]; then
        BUFFER="docker container exec -it ${selected_file} "
        CURSOR=$#BUFFER
    fi
}
zle -N fzf-docker_exec
bindkey '^e' fzf-docker_exec

function fzf-vim () {
    local selected_file=$(find . -name "*" -type f | grep -v ".typings/" | grep -v ".git/" | grep -v ".node_modules/" | grep -v ".next/" | grep -v ".out/" | grep -v ".__pycache__/" | fzf)
    if [ -n "$selected_file" ]; then
        BUFFER="vi ${selected_file}"
        CURSOR=$#BUFFER
    fi
}
zle -N fzf-vim
bindkey '^v' fzf-vim

# android sdk
export ANDROID_SDK=$HOME/Library/Android/sdk
export PATH=$ANDROID_SDK/platform-tools:$PATH

# other
# - environment
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

# proxy 
if [[ -s "${HOME}/.proxy.sh" ]]; then
  source "${HOME}/.proxy.sh"
fi

# last of file
eval "$(starship init zsh)"

# zsh-bd
. $HOME/.zsh/plugins/bd/bd.zsh

# AWS Profile
if [ -f ~/.config/aws-profile ]; then
  . ~/.config/aws-profile zsh
fi
