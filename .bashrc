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

if [[ -n "${XDG_RUNTIME_DIR}" ]]; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
fi

function ensure_ssh_agent() {
    ssh-add -l &> /dev/null
    case $? in
    0)
        echo "SSH Identity loaded ✅"
        ;;
    1)
        echo "SSH Agent running without identities"
        echo "  $ ssh-add; to continue"
        ;;
    2)
        eval `ssh-agent` > /dev/null
        ;;
    *)
        ;;
    esac
}
ensure_ssh_agent


# Put your fun stuff here.
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
# https://github.com/RoadieHQ/marketing-site/pull/858
alias techdocs='npx @techdocs/cli@1.2.0'
alias tmuxa='tmux a || tmux'
alias xclipp='([[ $XDG_SESSION_TYPE = wayland ]] && wl-copy -n || xclip -r -selection clipboard)'

# eix
export UPGRADE_TO_HIGHEST_SLOT=false

# Local binaries (python/pipsi)
if [[ -d "${HOME}/.local/bin" ]]; then
	export PATH="${HOME}/.local/bin:${PATH}"
fi

# Crystal
export PATH="${HOME}/Software/crystal-0.35.1-1/bin/:${PATH}"

# Go
export GOPATH="${HOME}/go"
GOROOT="${HOME}/Software/go"
export PATH="${GOROOT}/bin:${GOPATH}/bin:${PATH}"

# Gradle
export GRADLE_HOME="${HOME}/Software/gradle_build"
export PATH="${GRADLE_HOME}/bin:${PATH}"

# Guix
export GUIX_LOCATION="${HOME}/.guix-profile/lib/locale"
export PATH="${HOME}/.guix-profile/bin:${PATH}"

# Helm
export PATH="${HOME}/Software/helm/bin:${PATH}"

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

# Google Cloud SDK
export PATH="${HOME}/Software/google-cloud-sdk/bin:${PATH}"

# Javascript/Node
NODE_DIR="${HOME}/Software/node-linux-x64"
export PATH="${NODE_DIR}/bin:${PATH}"

# Javascript/Deno
export PATH="${HOME}/Software/deno/bin:${PATH}"

# k3s
export PATH="${HOME}/Software/k3s-1.19.2+k3s1/bin:${PATH}"

# k8s
export PATH="${HOME}/Software/kubernetes/bin:${PATH}"

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
if [[ -e "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

# Scala (sbt)
export SBT_HOME="${HOME}/Software/sbt-1.3.3"
export PATH="${SBT_HOME}/bin:${PATH}"

# reMarkable SDK
#source /opt/poky/2.1.3/environment-setup-cortexa9hf-neon-poky-linux-gnueabi

# aarch64-none-elf (Bare Metal compiler for ARM64 processors)
export PATH="/opt/linaro/gcc-arm-9.2-2019.12-x86_64-aarch64-none-elf/bin/:${PATH}"

# Wasmer
export WASMER_DIR="${HOME}/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# VSCode
export PATH="${PATH}:${HOME}/Software/VSCode-linux-x64/bin"

# Teleport
export PATH="${PATH}:${HOME}/Software/teleport"

# zoxide, comes after rust paths
# $ cargo install zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

if command -v aws_completer &> /dev/null; then
    complete -c "$(command -v aws_completer)" aws
fi

if command -v keychain &> /dev/null; then
    eval `keychain --eval id_ed25519`
fi

if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
fi

# https://krew.sigs.k8s.io/docs/user-guide/setup/install/
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# git clone https://github.com/pyenv/pyenv.git "${HOME}/.pyenv"
if [[ -e ~/.pyenv ]]; then
	export PATH="${HOME}/.pyenv/bin:${HOME}/.pyenv/shims:${PATH}"
fi

if [[ -e ~/bin ]]; then
	export PATH="${HOME}/bin:${PATH}"
fi

# \u: Username
# \h: Hostname
# \D: Timestamp Format:
#   : %F - ISO Date YYYY-MM-DD
#   : %T - Time     HH:MM:SS
# \w: Working Dir
export PS1='[\D{%F %T}] \u@\h:\w\$ '
