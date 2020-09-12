DOTPATH    :=  $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES :=  $(wildcard .??*) usr/bin
EXCLUSIONS :=  .git
DOTFILES_T :=  $(filter-out $(EXCLUSIONS), $(CANDIDATES))
DOTFILES   :=  $(sort $(shell /usr/bin/find $(DOTFILES_T) -type f))

all: help

help:
	@echo "make list           #=> Show dot files in this repo"
	@echo "make deploy         #=> Create symlink to home directory"
	@echo "make clean          #=> Remove the dot files and this repo"
#@echo "make init           #=> Setup environment settings"
#@echo "make test           #=> Test dotfiles and init scripts"
#@echo "make update         #=> Fetch changes for this repo"
#@echo "make install        #=> Run make update, deploy, init"

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy:
	@echo '==> start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), DOTPATH=$(DOTPATH) /bin/sh $(DOTPATH)/etc/deploy/deploy.sh $(abspath $(val)) $(HOME)/$(val);)
#@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

clean:
	@echo 'Remove dot files in your home directory.'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
