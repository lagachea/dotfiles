#!/bin/bash
#ZSH
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting

#FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
git clone https://github.com/Aloxaf/fzf-tab ~/.fzf-tab

#FD
brew install fd

#BAT
brew install bat

#RIPGREP
brew install ripgrep


mkdir -p ~/.config
mkdir -p ~/.zsh
#fd
cp -r fd ~
#zshrc
cp zsh/.zshrc ~
#zsh
cp -r zsh/.zsh ~
