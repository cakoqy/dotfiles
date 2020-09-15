set fish_greeting

set -x PATH $HOME/go/bin $PATH
set -x GO111MODULE on
set CFLAGS "-march=native -O2 -pipe"
set CXXFLAGS "$CFLAGS"

# alias batterh="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
alias cp 'cp -i'
alias rm 'rm -i'
alias mv 'mv -i'
alias vi "vim -u NONE -i NONE -N -c 'syntax on' -c 'colorscheme pablo'"
alias vim 'nvim'
# alias emacs 'emacs -nw'
# alias top 'htop -u $USER'

# alias tmuxx 'tmuxp load startup'

function fish_user_key_bindings
  bind \cr __fzf_history
end

function __fzf_history
  history | fzf-tmux -d40% +s +m --tiebreak=index --query=(commandline -b) \
    > /tmp/fzf
  and commandline (cat /tmp/fzf)
end

set -x PATH $HOME/.pyenv/bin $PATH
. (pyenv init - | psub)

# set -x PATH $HOME/.poetry/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/.skim/bin $PATH
set -x PATH $HOME/usr/local/bin $HOME/usr/bin $PATH

setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end

# Written in Rust
alias ls 'exa'  # https://github.com/ogham/exa
alias x 'exa'  # https://github.com/ogham/exa
alias grep 'rg'  # https://github.com/BurntSushi/ripgrep
alias cat 'bat'  # https://github.com/sharkdp/bat
alias find 'fd'  # https://github.com/sharkdp/fd
# alias sed 'sd'  # https://github.com/chmln/sd
# alias tldr 'tldr'  # https://github.com/dbrgn/tealdeer
alias ps 'procs'  # https://github.com/dalance/procs
alias du 'dust'  # https://github.com/bootandy/dust
alias top 'ytop'  # https://github.com/cjbassi/ytop
alias time 'hyperfine'  # https://github.com/sharkdp/hyperfine
# alias fzf 'sk'  # https://github.com/lotabout/skim
# bandwhich  https://github.com/imsnif/bandwhich

starship init fish | source

# vim: filetype=sh
