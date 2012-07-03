# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
#export ZSH_THEME="robbyrussell"
export ZSH_THEME="wezm"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

plugins=(git gem pip npm perl ssh-agent svn)
source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export ALTERNATE_EDITOR=emacs
export EDITOR=emacsclient
export VISUAL=emacsclient

# GIT aliases
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

alias gcm='git commit -a -m'
<<<<<<< HEAD
alias gdown='git pull --rebase origin $(current_branch)'
compdef gdown=git
alias gup='git push origin $(current_branch)'
compdef gup=git
=======
alias gs="ggpnp"

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append hg functions needed for prompt.
preexec_functions+='preexec_update_hg_vars'
precmd_functions+='precmd_update_hg_vars'
chpwd_functions+='chpwd_update_hg_vars'

plugins=(git osx ruby brew gem github pip)

# homebrew python
export PATH=/usr/local/share/python:/usr/local/sbin:/usr/local/bin:$PATH
#export GEM_HOME=/usr/local

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH=/usr/local/share/python:/usr/local/bin:$PATH
export GEM_HOME=/usr/local
export PATH=/usr/local/Cellar/ruby/1.9.3-p125/bin:$PATH
alias emacs='/usr/local/Cellar/emacs/HEAD/Emacs.app/Contents/MacOS/Emacs -nw'

# rails aliases
alias brake='SINGLE_THREADED=true bundle exec rake'
alias bserve='bundle exec rails s thin'
alias best='bundle exec rspec '
