all: .cache/vim .cache/neovim .cache/miniconda .cache/konsole .cache/zsh .cache/tmux .cache/latexmk

.cache/konsole: .cache/neovim | .cache
	stow konsole_config
	touch $@

.cache/antigen: | .cache
	mkdir -p $(HOME)/prog
	git clone https://github.com/zsh-users/antigen.git $(HOME)/prog/antigen
	touch $@

.cache/zsh: .cache/antigen | .cache
	stow zsh_config
	touch $@

.cache/tmux: | .cache
	stow tmux_config
	touch $@

.cache/vim: | .cache
	mkdir -p $(HOME)/.vim/autoload
	mkdir -p $(HOME)/.vim/plugged
	mkdir -p $(HOME)/.vim/undo
	mkdir -p $(HOME)/.vim/backup
	stow vim_config
	touch $@

.cache/neovim: .cache/vim .cache/miniconda | .cache
	mkdir -p $(HOME)/.local/share/nvim
	stow neovim_config
	nvim +PlugInstall +qall > /dev/null
	touch $@

.INTERMEDIATE: Miniconda3-latest-Linux-x86_64.sh

Miniconda3-latest-Linux-x86_64.sh:
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

.ONESHELL:
.cache/miniconda: Miniconda3-latest-Linux-x86_64.sh | .cache
	bash $^ -b -p $(HOME)/miniconda -s
	source $(HOME)/miniconda/bin/activate
	conda install -y ujson psutil
	pip install pynvim neovim-remote 'python-language-server[all]'
	touch $@

.cache/Ellana: | .cache
	stow Ellana_config
	systemctl --user daemon-reload
	touch $@

.cache/Edwin: | .cache
	stow Edwin_config
	systemctl --user daemon-reload
	touch $@

.cache/latexmk: | .cache
	stow latexmk_config
	touch $@

.cache/udd: | .cache
	stow udd_config
	touch $@

.cache:
	mkdir .cache

sun_keyboard:
	# see https://wiki.archlinux.org/index.php/Map_scancodes_to_keycodes
	sudo cp sun_keyboard_config/70-keyboard.hwdb /etc/lib/udev/hwdb.d/
	sudo systemd-hwdb update

clean:
	stow -D konsole_config
	rm -rf .cache/konsole
	rm -rf $(HOME)/prog/antigen
	rm -rf .cache/antigen
	stow -D zsh_config
	rm -rf .cache/zsh
	stow -D tmux_config
	rm -rf .cache/tmux
	stow -D vim_config
	rm -rf $(HOME)/.vim
	rm -rf .cache/vim
	stow -D neovim_config
	rm -rf $(HOME)/.local/share/nvim
	rm -rf .cache/neovim
	rm -rf $(HOME)/miniconda
	rm -rf .cache/miniconda
	stow -D Ellana_config
	rm -rf .cache/Ellana
	stow -D latexmk_config
	rm -rf .cache/latexmk
	stow -D udd_config
	rm -rf .cache/udd
