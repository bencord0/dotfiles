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

# Put your fun stuff here.
[ -r /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh
[ -r /usr/share/bash-completion/completions/pass ] && \
  source /usr/share/bash-completion/completions/pass

[ -r "${HOME}/src/arcanist/resources/shell/bash-completion" ] && \
  source "${HOME}/src/arcanist/resources/shell/bash-completion"

for thing in \
            cargo \
            docker \
            git-completion.bash \
            password-store \
            tmux; do
  [ -r "/usr/local/etc/bash_completion.d/${thing}" ] && \
  source "/usr/local/etc/bash_completion.d/${thing}"
done

if command -v aws_completer; then
    complete -c "$(command -v aws_completer)" aws
fi

if command -v kubectl; then
    source <(kubectl completion bash)
fi

# limit virtual memory to 1g
#ulimit -v 1000000
alias abspath='readlink -f'
alias ci='docker-compose -f docker-compose.ci.yml -p project'
alias open='xdg-open'
alias r='less -r'
alias rpatch='patch -p1 -R'
alias tmuxa='tmux a || tmux'
alias xclipp='xclip -selection clipboard'

# eix
export UPGRADE_TO_HIGHEST_SLOT=false

# Local binaries
export PATH="${HOME}/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"

# Go
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${PATH}"

# Gradle
export GRADLE_HOME="${HOME}/gradle_build"
export PATH="${GRADLE_HOME}/bin:${PATH}"

# Guix
export GUIX_LOCATION="${HOME}/.guix-profile/lib/locale"
export PATH="${HOME}/.guix-profile/bin:${PATH}"

## dev-java/openjdk-bin:11
## This is installed by portage, but not visible to eselect.
export JDK_9="/opt/openjdk-bin-11.0.4_p11"

## dev-java/icedtea-bin:8 (stable)
## This is the system java-vm set by eselect.
export JDK_18="/opt/icedtea-bin-3.13.0"
export JDK_17="/opt/icedtea-bin-3.13.0" # Lies
export JDK_16="/opt/icedtea-bin-3.13.0" # Lies

# Java/JRE/JDK
export JAVA_HOME="${JDK_9}"
export PATH="${JAVA_HOME}/bin:${PATH}"

# Kotlin
export PATH="${HOME}/kotlin-native/bin:${PATH}"
export PATH="${HOME}/kotlin/bin:${PATH}"

# NodeJS
export PATH="${HOME}/.yarn/bin:${PATH}"

# Python
## python-3.8 is not yet visible to eselect.
export PATH="${HOME}/py38/bin:${PATH}"

# Ruby
if [[ -d "${HOME}/.rbenv" ]]; then
    export PATH="${HOME}/.rbenv/bin:${PATH}"
    eval "$(rbenv init -)"
fi

# Rust
export PATH="${PATH}:${HOME}/.cargo/bin"

