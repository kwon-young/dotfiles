all: konsole zsh tmux

konsole:
	stow konsole_config

antigen:
	mkdir -p $(HOME)/prog
	git clone https://github.com/zsh-users/antigen.git $(HOME)/prog/antigen

zsh: antigen
	stow zsh_config

tmux:
	stow tmux_config

vim:
	mkdir -p $(HOME)/.vim/autoload
	mkdir -p $(HOME)/.vim/plugged
	mkdir -p $(HOME)/.vim/undo
	mkdir -p $(HOME)/.vim/backup
	stow vim_config

neovim: vim miniconda
	ln -sf $(HOME)/.vim $(HOME)/.config/nvim
	mkdir -p $(HOME)/.local/share/nvim
	ln -sf $(HOME)/.vim/backup $(HOME)/.local/share/nvim/backup
	ln -sf $(HOME)/.vim/undo $(HOME)/.local/share/nvim/undo

.INTERMEDIATE: Miniconda3-latest-Linux-x86_64.sh

Miniconda3-latest-Linux-x86_64.sh:
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

.ONESHELL:
miniconda: Miniconda3-latest-Linux-x86_64.sh
	bash $^ -b -p $(HOME)/miniconda -s
	source $(HOME)/miniconda/bin/activate
	conda install -y ujson psutil
	pip install pynvim neovim-remote 'python-language-server[all]'

clean:
	stow -D konsole_config
	rm -rf $(HOME)/prog/antigen
	stow -D zsh_config
	stow -D tmux_config
	stow -D vim_config
	rm -rf $(HOME)/.vim
	rm -rf $(HOME)/.config/nvim
	rm -rf $(HOME)/.local/share/nvim
	rm -rf $(HOME)/miniconda
