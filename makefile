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
SRC_GINIT = ginit.vim
PLUGGED = plugged
PLUG = ../vim-plug/plug.vim
SRC_SPELL = /home/dmosuser/SSH_udd/.vim/spell/*.spl
s+ = $(shell echo $1 | sed 's/ /\\ /g')
FONT_FILES = $(notdir $(shell find $(DOTFILES) -iname '*.otf' | sed 's/ /\\ /g'))
KONSOLE_COLOR = $(HOME)/.config/nvim/plugged/seoul256.vim/kde/seoul256.colorscheme
KONSOLE_DIR = $(HOME)/.local/share/konsole

all:
	@echo "Creating dir"
	mkdir -p $(NVIM_PATH)
	mkdir -p $(VIM_PATH)
	(cd $(NVIM_PATH); mkdir -p $(SUBDIR))
	(cd $(VIM_PATH); mkdir -p $(SUBDIR) $(PLUGGED))
	@echo "Creating symbolic link"
	(cd $(NVIM_PATH); ln -sf $(DOTFILES)/$(SRC_INIT) init.vim)
	(cd $(NVIM_PATH); ln -sf $(DOTFILES)/$(SRC_GINIT) ginit.vim)
	(cd $(NVIM_PATH); ln -sf $(VIM_PATH)/$(PLUGGED) $(PLUGGED))
	(cd $(NVIM_PATH)/$(AUTOLOAD); ln -sf $(DOTFILES)/$(PLUG) plug.vim)
	(cd $(HOME); ln -sf $(DOTFILES)/$(SRC_INIT) .vimrc)
	(cd $(VIM_PATH)/$(AUTOLOAD); ln -sf $(DOTFILES)/$(PLUG) plug.vim)
	#@echo "Copying spell files"
	#(cd $(NVIM_PATH)/$(SPELL); cp $(SRC_SPELL) .)
	#(cd $(VIM_PATH)/$(SPELL); cp $(SRC_SPELL) .)

.PHONY: $(FONT_FILES)

font: font_dir $(FONT_FILES)
	fc-cache -fv
	@echo "===================="
font_dir:
	(cd $(HOME); mkdir -p .fonts)

$(FONT_FILES):
	@echo "installing font"
	(cd $(HOME)/.fonts; ln -sf $(DOTFILES)/$(call s+,$@) $(call s+,$@))

konsole:
	(cd $(KONSOLE_DIR); ln -sf $(KONSOLE_COLOR) seoul256.colorscheme)
	(cd $(KONSOLE_DIR); ln -sf $(HOME)/prog/dotfiles/kwon-young.profile kwon-young.profile)

