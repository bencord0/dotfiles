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


# Put your fun stuff here.
[ -r /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh
[ -r /usr/share/bash-completion/completions/pass ] && \
  source /usr/share/bash-completion/completions/pass

for thing in \
            cargo \
            docker \
            password-store \
            tmux; do
  [ -r /usr/local/etc/bash_completion.d/$thing ] && \
  source /usr/local/etc/bash_completion.d/$thing
done


# limit virtual memory to 1g
#ulimit -v 1000000
alias tmuxa='tmux a || tmux'

eval $(docker-machine env default)
