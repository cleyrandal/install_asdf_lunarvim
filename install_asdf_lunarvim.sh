#!/usr/bin/bash

# DISTRIB_ID="ManjaroLinux"
# DISTRIB_RELEASE="24.0.2"
# DISTRIB_CODENAME="Wynsdey"
# DISTRIB_DESCRIPTION="Manjaro Linux"


# Install basic packages and nerd fonts
sudo pacman -S --needed base-devel
sudo pacman -S --needed openssl
sudo pacman -S --needed zlib
sudo pacman -S --needed xz
sudo pacman -S --needed tk
sudo pacman -S --needed python-pip
sudo pacman -S --needed xclip
sudo pacman -S --needed powerline-fonts
sudo pacman -S --needed awesome-terminal-fonts
sudo pacman -S --needed ttf-nerd-fonts-symbols
sudo pacman -S --needed ranger

# Install asdf
cd /tmp
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo '' >> ~/.bashrc
echo '# cleyrandal' >> ~/.bashrc
echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc
source ~/.bashrc

# python
asdf plugin-add python
asdf install python stable
asdf global python system

# nodejs
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest
npm i -g npm
asdf reshim nodejs

# rust
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf install rust stable
asdf global rust stable

# pipx
asdf plugin add pipx https://github.com/yozachar/asdf-pipx.git
asdf install pipx latest
asdf global pipx latest

# poetry
asdf plugin-add poetry https://github.com/asdf-community/asdf-poetry.git
asdf install poetry latest
asdf global poetry latest

# ripgrep
asdf plugin add ripgrep
asdf install ripgrep latest
asdf global ripgrep latest

# neovim
asdf plugin add neovim
asdf install neovim stable
asdf global neovim stable

# reshim
asdf reshim

# Checking all the versions of the necessary dependencies.
git --version; make --version|grep Make; pip --version; python -V; npm --version; node --version; cargo --version; rg -V; nvim -v

# LunarVim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

# From here, answer [y]es to all questions.

# replace config.lua
mv ~/.config/lvim/config.lua ~/.config/lvim/config.lua.bkp
ln -vs "$(pwd)/config.lua" ~/.config/lvim/


## FIM
