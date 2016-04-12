NVIM_PATH = $(HOME)/.config/nvim
VIM_PATH = $(HOME)/.vim
UNDO = undo
BACKUP = backup
SWP = swp
AUTOLOAD = autoload
SPELL = spell
SUBDIR = $(UNDO) $(BACKUP) $(SWP) $(AUTOLOAD) $(SPELL)
DOTFILES = $(CURDIR)
SRC_INIT = init.vim
PLUGGED = plugged
PLUG = vim-plug/plug.vim
SRC_SPELL = /home/dmosuser/SSH_udd/.vim/spell/*.spl

all:
	@echo "Creating dir"
	mkdir -p $(NVIM_PATH)
	mkdir -p $(VIM_PATH)
	(cd $(NVIM_PATH); mkdir -p $(SUBDIR))
	(cd $(VIM_PATH); mkdir -p $(SUBDIR) $(PLUGGED))
	@echo "Creating symbolic link"
	(cd $(NVIM_PATH); ln -sf $(DOTFILES)/$(SRC_INIT) init.vim)
	(cd $(NVIM_PATH); ln -sf $(VIM_PATH)/$(PLUGGED) $(PLUGGED))
	(cd $(NVIM_PATH)/$(AUTOLOAD); ln -sf $(DOTFILES)/$(PLUG) plug.vim)
	(cd $(HOME); ln -sf $(DOTFILES)/$(SRC_INIT) .vimrc)
	(cd $(VIM_PATH)/$(AUTOLOAD); ln -sf $(DOTFILES)/$(PLUG) plug.vim)
	@echo "Copying spell files"
	(cd $(NVIM_PATH)/$(SPELL); cp $(SRC_SPELL) .)
	(cd $(VIM_PATH)/$(SPELL); cp $(SRC_SPELL) .)

