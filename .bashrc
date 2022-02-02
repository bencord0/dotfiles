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

# Scroll correctly
LESS="$LESS --mouse"

GPG_TTY="$(tty)"
if [[ -n "${GPG_TTY}" ]]; then
    export GPG_TTY
fi

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# Put your fun stuff here.
[ -r /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

[ -r "${HOME}/src/arcanist/resources/shell/bash-completion" ] && \
  source "${HOME}/src/arcanist/resources/shell/bash-completion"

for thing in \
            cargo \
            docker \
            git-completion.bash \
            pass \
            pass-otp \
            tmux; do
  if [[ -r "/usr/local/etc/bash_completion.d/${thing}" ]]; then
    source "/usr/local/etc/bash_completion.d/${thing}"
    continue
  fi

  if [[ -r "/usr/share/bash-completion/completions/${thing}" ]]; then
    source "/usr/share/bash-completion/completions/${thing}"
    continue
  fi
done

if command -v aws_completer &> /dev/null; then
    complete -c "$(command -v aws_completer)" aws
fi

if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
fi

# Pushover client
if [[ -f "${HOME}/.pushover" ]]; then
    source "${HOME}/.pushover"
fi

# limit virtual memory to 1g
#ulimit -v 1000000
alias abspath='readlink -f'
alias ci='docker-compose -f docker-compose.ci.yml -p project'
alias open='xdg-open'
alias r='less -r'
alias rpatch='patch -p1 -R'
alias tmuxa='tmux a || tmux'
alias xclipp='([[ $XDG_SESSION_TYPE = wayland ]] && wl-copy -n || xclip -r -selection clipboard)'

# eix
export UPGRADE_TO_HIGHEST_SLOT=false

# Local binaries
export PATH="${HOME}/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"

# Crystal
export PATH="${HOME}/Software/crystal-0.35.1-1/bin/:${PATH}"

# Go
#export GOROOT="${HOME}/Software/go-1.14"
#export GOROOT="${HOME}/Software/go-1.15"
#export GOROOT="${HOME}/Software/go-1.16"
export GOROOT="${HOME}/Software/go-1.17"
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${GOROOT}/bin:${PATH}"

# Gradle
export GRADLE_HOME="${HOME}/Software/gradle_build"
export PATH="${GRADLE_HOME}/bin:${PATH}"

# Guix
export GUIX_LOCATION="${HOME}/.guix-profile/lib/locale"
export PATH="${HOME}/.guix-profile/bin:${PATH}"

## dev-java/openjdk-bin:11
## This is installed by portage, but not visible to eselect.
#export JDK_9="/opt/openjdk-bin-11.0.4_p11"

## dev-java/icedtea-bin:8 (stable)
## This is the system java-vm set by eselect.
export JDK_18="/opt/icedtea-bin-3.16.0"
export JDK_17="/opt/icedtea-bin-3.16.0" # Lies
export JDK_16="/opt/icedtea-bin-3.16.0" # Lies

# Java/JRE/JDK
export JAVA_HOME="${JDK_18}"
export PATH="${JAVA_HOME}/bin:${PATH}"

# Android
#export ANDROID_SDK_ROOT="${HOME}/Android/Sdk"         # dev-util/android-studio
#export ANDROID_SDK_ROOT="${HOME}/Software/android-11" # https://dl.google.com/android/repository/platform-30_r01.zip
export ANDROID_PLATFORM_TOOLS="${HOME}/Android/Sdk/platform-tools"
export PATH="${PATH}:${ANDROID_PLATFORM_TOOLS}"

# Javascript/Node
NODE_DIR="${HOME}/Software/node-v12.18.3-linux-x64"
export PATH="${NODE_DIR}/bin:${PATH}"

# k3s
export PATH="${HOME}/Software/k3s-1.19.2+k3s1/bin:${PATH}"

# Kotlin
export PATH="${HOME}/Software/kotlin-native/bin:${PATH}"
export PATH="${HOME}/Software/kotlinc/bin:${PATH}"

# NodeJS
export PATH="${HOME}/.yarn/bin:${PATH}"

# Ruby
if [[ -d "${HOME}/.rbenv" ]]; then
    export PATH="${HOME}/.rbenv/bin:${PATH}"
    eval "$(rbenv init -)"
fi

# Rust
export PATH="${HOME}/.cargo/bin:${PATH}"

# Scala (sbt)
export SBT_HOME="${HOME}/Software/sbt-1.3.3"
export PATH="${SBT_HOME}/bin:${PATH}"

# reMarkable SDK
#source /opt/poky/2.1.3/environment-setup-cortexa9hf-neon-poky-linux-gnueabi

# aarch64-none-elf (Bare Metal compiler for ARM64 processors)
export PATH="${PATH}:/opt/linaro/gcc-arm-9.2-2019.12-x86_64-aarch64-none-elf/bin/"

# Wasmer
export WASMER_DIR="${HOME}/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# VSCode
export PATH="${PATH}:${HOME}/Software/VSCode-linux-x64/bin"

# zoxide, comes after rust paths
# $ cargo install zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

if [[ -e "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi
