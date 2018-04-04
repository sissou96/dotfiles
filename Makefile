DOTFILES := $(shell pwd)

all: update i3-gaps polybar rofi hydrate-dotfiles slim 

update:
	sudo apt-get update

ifeq ($(DISTRO),Ubuntu)
	sudo add-apt-repository ppa:aguignard/ppa
	sudo apt-get update
	sudo apt-get install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev
else
	sudo apt-get install -y libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev
endif

i3-gaps:
	mkdir -p temp && \
	cd temp && \
	git clone https://www.github.com/Airblader/i3 i3-gaps && \
	cd i3-gaps && \
	autoreconf --force --install && \
	rm -rf build/ && \
	mkdir -p build && cd build/ && \
	../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers && \
	make && \
	sudo make install

polybar:
	sudo apt-get install -y python-xcbgen libxcb-ewmh-dev libxcb-icccm4-dev libxcb1-dev \
	xcb-proto libxcb-util-dev libxcb-image0-dev libxcb-randr0-dev libxcb-xkb-dev \
	libalsaplayer-dev wireless-tools libcurlpp-dev libcairo2-dev
	mkdir -p temp && cd temp/ && \
	git clone --branch 3.1.0 --recursive https://github.com/jaagr/polybar && \
	cd polybar && \
	./build.sh

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
	ln -fs $(DOTFILES)/.config/rofi $(HOME)/.config/rofi
	ln -fs $(DOTFILES)/.config/polybar $(HOME)/.config/polybar
	ln -fs $(DOTFILES)/.config/gtk-3.0 $(HOME)/.config/gtk-3.0
	ln -fs $(DOTFILES)/.config/slim $(HOME)/.config/slim
