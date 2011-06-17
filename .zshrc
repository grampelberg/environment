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

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export ALTERNATE_EDITOR=emacs
export EDITOR=emacsclient
export VISUAL=emacsclient

# SVN helper functions
svnstatus () {
    templist=`svn status $*`
    echo `echo $templist | grep '^?' | wc -l` unversioned files/directories
    echo $templist | grep -v '^?'
}

svnup () {
    svn log --stop-on-copy -r HEAD:BASE $1
    svn up $1
}

svndiff() {
    svn diff | emacspipe
}

function svn_prompt_info() {
    branch=$(svn_current_branch) || return
    echo "$ZSH_THEME_SVN_PROMPT_PREFIX$branch$(parse_svn_dirty)$ZSH_THEME_SVN_PROMPT_SUFFIX"
}

parse_svn_dirty() {
    if [[ $(svn diff 2> /dev/null) != "" ]]; then
        echo "$ZSH_THEME_SVN_PROMPT_DIRTY"
    else
        echo "$ZSH_THEME_SVN_PROMPT_CLEAN"
    fi
}

svn_current_branch() {
    svn info 2> /dev/null | grep '^URL:' | egrep -o '(tags|branches)/[^/]+|trunk' | egrep -o '[^/]+$'
}

emacspipe() {
    unset DISPLAY

    tmp_file="$(mktemp)"
    lisp_to_accept_file="(fake-stdin-slurp \"${tmp_file}\")"

    if [ ! -t 0  ]; then
        cat > "${tmp_file}"

        emacsclient -a emacs -e "${lisp_to_accept_file}" ${@}

        if [ ${?} -ne 0 ]; then
            echo "failed: your input was saved in '${tmp_file}'"
        else
            rm -f "${tmp_file}"
        fi
    else
    # nothing from stdin
        emacsclient -n -a emacs ${@}
    fi
}

alias sstat='svnstatus'
export ENVJS=~/code/env-js
alias js="java -cp $ENVJS/rhino/js.jar:$ENVJS/rhino/jline.jar \
    -Xbootclasspath/p:$ENVJS/rhino/js.jar:$ENVJS/rhino/jline.jar \
    jline.ConsoleRunner org.mozilla.javascript.tools.shell.Main -opt -1 "

# GIT aliases
alias gcm='git commit -a -m'


autoload -U $ZSH/functions/*(:t)

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append hg functions needed for prompt.
preexec_functions+='preexec_update_hg_vars'
precmd_functions+='precmd_update_hg_vars'
chpwd_functions+='chpwd_update_hg_vars'

plugins=(git osx ruby brew gem github pip)

export ALTERNATE_EDITOR=emacs
export EDITOR=emacsclient
export VISUAL=emacsclient
export M2_HOME=/Applications/liftweb-1.0/apache-maven
export M2=$M2_HOME/bin
export MAVEN_OPTS="-noverify -javaagent:/Applications/liftweb-1.0/java-rebel/javarebel.jar"
export PATH=$M2:$PATH
export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

# Get emacsclient working using the right version.
export PATH=/Applications/MacPorts/Emacs.app/Contents/MacOS/bin:$PATH

# Make gems usable on the path
export PATH=~/.gem/ruby/1.8/bin:/var/lib/gems/1.8/bin:$PATH

# Put the chef helpers on the path
export PATH=~/code/chef-repo/bin:$PATH

# Sproutcore's abbot stuff.
export PATH=~/code/abbot/bin:$PATH

# seed.js
export PATH=~/.seeds/bin:$PATH

# homebrew python
export PATH=/usr/local/Cellar/python/2.7.1/bin:/usr/local/sbin:$PATH
export GEM_HOME=/usr/local/Cellar/gems/1.9

#npm
export PATH=/usr/local/share/npm/bin:$PATH

