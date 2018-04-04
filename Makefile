DOTFILES := $(shell pwd)

all: update i3-gaps polybar rofi hydrate-dotfiles slim 

update:
	sudo apt-get update

i3-gaps:
	sudo apt-get install -y libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev
	mkdir -p temp
	cd temp
	git clone https://www.github.com/Airblader/i3 i3-gaps
	cd i3-gaps
	autoreconf --force --install
	rm -rf build/
	mkdir -p build && cd build/
	../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
	make
	sudo make install

polybar:
	sudo apt-get install cairo libxcb python2 xcb-proto gcc xcb-util-image xcb-util-wm xcb-util-xrm alsa-lib libpulse jsoncpp
	mkdir -p temp && cd temp/
	git clone --branch 3.1.0 --recursive https://github.com/jaagr/polybar
	cd polybar
	.build.sh

rofi:
	sudo apt-get install rofi

spacemacs:
	sudo apt-get install emacs
	git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

slim:
	sudo apt-get install slim
	sudo cp $(HOME)/.config/slim/themes/slim-hud /usr/share/slim/themes/	
	sudo cp $(DOTFILES)/.config/slim/slim.conf /etc/slim.conf

gtk3:
	sudo apt-get install lxappearance gtk3

hydrate-dotfiles:
	ln -fs $(DOTFILES)/.Xdefaults $(HOME)/.Xdefaults
	ln -fs $(DOTFILES)/.Xmodmap $(HOME)/.Xmodmap
	ln -fs $(DOTFILES)/.Xresources $(HOME)/.Xresources
	ln -fs $(DOTFILES)/.bashrc $(HOME)/.bashrc
	ln -fs $(DOTFILES)/.profile $(HOME)/.profile
	ln -fs $(DOTFILES)/.spacemacs $(HOME)/.spacemacs
	ln -fs $(DOTFILES)/.tmux.conf $(HOME)/.tmux.conf
	ln -fs $(DOTFILES)/.vimrc $(HOME)/.vimrc
	ln -fs $(DOTFILES)/.xinitrc $(HOME)/.xinitrc
	ln -fs $(DOTFILES)/.gitignore $(HOME)/.gitignore
	mkdir -p $(HOME)/.config
	ln -fs $(DOTFILES)/.config/i3 $(HOME)/.config/i3
	ln -fs $(dotfiles)/.config/rofi $(home)/.config/rofi
	ln -fs $(dotfiles)/.config/polybar $(home)/.config/polybar
	ln -fs $(dotfiles)/.config/gtk-3.0 $(home)/.config/gtk-3.0
	ln -fs $(dotfiles)/.config/slim $(home)/.config/slim
