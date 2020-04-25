     ___      ___
    |"  \    /"  |  aztecrabbit@home
    |\   \  //   |  ----------------
    |'\\  \/.    |  OS: Manjaro Linux x86_64
    |: \.        |  WM: bspwm
    |.  \    /:  |  Shell: zsh
    |___|\__/|___|


Packages
--------

    antigen-git
    aria2
    bat
    bspwm-git
    dash
    dmenu
    dunst
    ecryptfs-utils
    exa
    ffscreencast
    fzy
    gtk-youtube-viewer-git
    gucharmap
    httping
    lxappearance
    megacmd-bin
    mpc
    mpd
    mpv
    ncmpcpp
    neomutt
    neovim
    pgcli
    polybar
    powerpill
    redsocks
    rofi
    scrot
    shadowsocks-libev
    simple-obfs-git
    sncli
    stow
    subfinder-bin
    sxhkd-git
    syncthing
    telegram-desktop
    tmux
    ttf-font-awesome
    ttf-material-design-icons
    unrar
    urlscan
    xclip
    xdman
    xdo
    zscroll-git
    zsh

<!-- -->

    $ yay -S antigen-git aria2 bat bspwm-git dash dmenu dunst ecryptfs-utils exa ffscreencast fzy gtk-youtube-viewer-git gucharmap httping lxappearance megacmd-bin mpc mpd mpv ncmpcpp neomutt neovim pgcli polybar powerpill redsocks rofi scrot shadowsocks-libev simple-obfs-git sncli stow subfinder-bin sxhkd-git syncthing telegram-desktop tmux ttf-font-awesome ttf-material-design-icons unrar urlscan xclip xdman xdo zscroll-git zsh


Termux
------

    $ apt install exa stow zsh
    $ curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh > ~/.antigen.zsh


Usage
-----

    $ git clone https://github.com/aztecrabbit/.dotfiles ~/.dotfiles
    $ cd ~/.dotfiles

    $ stow --verbose --no-folding -R zsh

Termux stop here

    $ sudo stow --verbose --no-folding -t / -R aria2 makepkg pacman powerpill

Close terminal and open again

    $ ln -sf /usr/bin/dash /usr/bin/sh

    $ cd ~/.dotfiles
    $ stow --verbose --no-folding -R bin bspwm compton dunst etc fonts mpd mpv ncmpcpp neomutt neovim pyradio rofi scripts sublime-text-3 thunar tmux tumbler urxvt xdman youtube-viewer
