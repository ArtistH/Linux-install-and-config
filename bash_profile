#
# ~/.bashrc
#

# PATH
PATH=$PATH:/usr/local/sbin:/usr/local/bin
export PATH

# bash-completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	. /usr/share/bash-completion/bash_completion

# Have Time ahead
# PS1='\[\033[0;32m\]\A \[\033[0;31m\]\u\[\033[0;34m\] \[\033[00;36m\]\W\[\033[0;33m\] \$\[\033[0m\] ' 
PS1='\[\033[0;31m\]\u\[\033[0;34m\] \[\033[00;36m\]\W\[\033[0;33m\] \$\[\033[0m\] '

eval "`dircolors -b`"
alias ls="ls --color=auto"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="grep --color=auto"
alias egrep="egrep --color=auto"
alias ll="ls -l"

export LANG="zh_CN.UTF-8"
