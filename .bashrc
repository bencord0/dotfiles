# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

export GPG_TTY=$(tty)
export PATH="$PATH:$HOME/bin"

# Put your fun stuff here.
[ -r /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh
[ -r /usr/share/bash-completion/completions/pass ] && \
  source /usr/share/bash-completion/completions/pass

[ -r ~/src/arcanist/resources/shell/bash-completion ] && \
  source ~/src/arcanist/resources/shell/bash-completion

for thing in \
            cargo \
            docker \
            git-completion.bash \
            password-store \
            tmux; do
  [ -r /usr/local/etc/bash_completion.d/$thing ] && \
  source /usr/local/etc/bash_completion.d/$thing
done

if hash kubectl 2>/dev/null; then
    source <(kubectl completion bash)
fi

# limit virtual memory to 1g
#ulimit -v 1000000
alias tmuxa='tmux a || tmux'
alias r='less -r'
alias open='xdg-open'
alias rpatch='patch -p1 -R'

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# node
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# eix
export UPGRADE_TO_HIGHEST_SLOT=false

alias abspath='readlink -f'

