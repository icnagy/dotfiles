# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
UNBUNDLED_COMMANDS=(irb)
plugins=(bundler git rails ruby chruby npm node brew hub rake)

source $ZSH/oh-my-zsh.sh

export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"
export GEM_HOME=$HOME/gems

unsetopt correct_all

alias poly="source $HOME/.poly/polygot.bash"
poly load zsh git ruby rails mysql


[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

function gi() { curl https://www.gitignore.io/api/$@ ;}

alias cq="echo 'Running flog...' && flog app && echo 'Running rubocop...' && rubocop -a"

setopt interactivecomments

# Setup editor for long commands
export EDITOR="mvim -f"

# Setup kick ass zmv and mmv
autoload -U zmv
alias mmv='noglob zmv -W'
