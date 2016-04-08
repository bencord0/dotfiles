HOST:=
GPG_TTY=$(shell tty)


all: _$(HOST)
	@test -n "$(HOST)"

_:
	@echo "You have not set the `HOST` variable."
	@echo "I don't know which host to install dotfiles for"

_link:
	@echo "Installing dotfiles for [link]"
	ln -svf "$(PWD)/.bashrc" $(HOME)/.bashrc
	ln -svf "$(PWD)/.gitconfig" $(HOME)/.gitconfig
	ln -svf "$(PWD)/.muttrc" $(HOME)/.muttrc
	ln -svf "$(PWD)/.tmux.conf" $(HOME)/.tmux.conf
	ln -svf "$(PWD)/.vimrc" $(HOME)/.vimrc
	ln -svf "$(PWD)/.Xresources" $(HOME)/.Xresources
	ln -svf "$(PWD)/.ssh" $(HOME)/
	ln -svf "$(HOST)-id_ed25519.pub" .ssh/id_ed25519.pub
	ln -svf "$(HOST)-id_rsa.pub" .ssh/id_rsa.pub
	sh -c 'gpg -d < ".ssh/$(HOST)-id_ed25519" > .ssh/id_ed25519'
	sh -c 'gpg -d < ".ssh/$(HOST)-id_rsa" > .ssh/id_rsa'

_mbp:
	@echo "Installing dotfiles for [mbp]"
	ln -svf "$(PWD)/.bashrc" $(HOME)/.bashrc
	ln -svf "$(PWD)/.gitconfig" $(HOME)/.gitconfig
	ln -svf "$(PWD)/.tmux.conf" $(HOME)/.tmux.conf
	ln -svf "$(PWD)/.vimrc" $(HOME)/.vimrc




.PHONY: all _ _link

