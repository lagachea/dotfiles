#!/bin/bash
#ZSH
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting

#FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
git clone https://github.com/Aloxaf/fzf-tab ~/.fzf-tab

#BAT
brew install bat

#RIPGREP
brew install ripgrep


# setup links
USERPATH="/home/yassine/dotfiles"

#bat
ln -s -t ~/.config /home/yassine/dotfiles/bat 
#fd
ln -s -t ~/.config /home/yassine/dotfiles/fd
#zshrc
ln -s -t ~/ /home/yassine/dotfiles/zsh/.zshrc
#zsh
ln -s -t ~/.zsh /home/yassine/dotfiles/zsh/.zsh
