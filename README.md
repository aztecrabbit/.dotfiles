     ___      ___
    |"  \    /"  |  aztecrabbit@home
    |\   \  //   |  ----------------
    |'\\  \/.    |  OS: Manjaro Linux x86_64
    |: \.        |  WM: bspwm
    |.  \    /:  |  Shell: zsh
    |___|\__/|___|


Packages
--------

| Name                            | Description |
| ----                            | ----------- |
| antigen-git                     | Plugin manager for zsh, inspired by oh-my-zsh and vundle |
| aria2                           | Download utility that supports HTTP(S), FTP, BitTorrent, and Metalink |
| bat                             | Cat clone with syntax highlighting and git integration |
| bspwm-git                       | Tiling Window Manager based on binary space partitioning |
| dash                            | POSIX compliant shell that aims to be as small as possible |
| dmenu                           | Generic menu for X |
| dunst                           | Customizable and lightweight notification-daemon |
| ecryptfs-utils                  | Enterprise-class stacked cryptographic filesystem for Linux |
| exa                             | ls replacement |
| ffscreencast                    | ffmpeg screencast/desktop-recording with video overlay and multi monitor support |
| fzy                             | A better fuzzy finder |
| gtk-youtube-viewer-git          | GTK+ application for searching and streaming videos from YouTube |
| gucharmap                       | Gnome Unicode Charmap |
| httping                         | Ping-like tool for http-requests |
| lxappearance                    | Feature-rich GTK+ theme switcher of the LXDE Desktop |
| megacmd-bin                     | MEGA Command Line Interactive and Scriptable Application |
| mpc                             | Minimalist command line interface to MPD |
| mpd                             | Flexible, powerful, server-side application for playing music |
| mpv                             | Free, open source, and cross-platform media player |
| ncmpcpp                         | Almost exact clone of ncmpc (Fully featured MPD client using ncurses) with some new features |
| neomutt                         | A version of mutt with added features |
| neovim                          | Fork of Vim aiming to improve user experience, plugins, and GUIs |
| pgcli                           | Command line interface for Postgres with auto-completion and syntax highlighting |
| picom                           | X compositor that may fix tearing issues |
| polybar                         | Fast and easy-to-use status bar |
| powerpill                       | Pacman wrapper for faster download |
| redsocks                        | Transparent redirector of any TCP connection to proxy using your firewal |
| rofi                            | Window switcher |
| scrot                           | Simple command-line screenshot utility for X |
| shadowsocks-libev               | Lightweight secured socks5 proxy for embedded devices and low end boxes |
| simple-obfs-git                 | Simple obfusacting tool designed as plugin server of shadowsocks |
| stow                            | Manage installation of multiple softwares in the same directory tree |
| subfinder-bin                   | subdomain discovery tool |
| sxhkd-git                       | Simple X hotkey daemon |
| syncthing                       | Synchronize files bidirectionally across multiple devices |
| telegram-desktop                | Official Telegram Desktop client |
| tmux                            | Terminal multiplexer |
| ttf-font-awesome                | Iconic font designed for Bootstrap |
| ttf-material-design-icons       | Material Design icons by Google |
| unrar                           | RAR uncompression program |
| urlscan                         | Mutt and terminal url selector |
| wmname                          | Utility to set the name of your window manager |
| xclip                           | Command line interface to the X11 clipboard |
| xdman                           | Powerful tool to increase download speed up-to 500% |
| xdo                             | Utility for performing actions on windows in X |
| zscroll-git                     | Horizontal text scroller for use with panels |
| zsh                             | Very advanced and programmable command interpreter (shell) for UNIX |

    $ yay -S antigen-git aria2 bat bspwm-git dash dmenu dunst ecryptfs-utils exa ffscreencast fzy gtk-youtube-viewer-git gucharmap httping lxappearance megacmd-bin mpc mpd mpv ncmpcpp neomutt neovim pgcli picom polybar powerpill redsocks rofi scrot shadowsocks-libev simple-obfs-git sncli stow subfinder-bin sxhkd-git syncthing telegram-desktop tmux ttf-font-awesome ttf-material-design-icons unrar urlscan wmname xclip xdman xdo zscroll-git zsh


Termux
------

    $ apt install exa stow zsh
    $ curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh > ~/.antigen.sh


Usage
-----

    $ git clone https://github.com/aztecrabbit/.dotfiles ~/.dotfiles
    $ cd ~/.dotfiles

    $ stow --verbose --no-folding -R zsh
    $ chsh -s $(which zsh)

Termux stop here

    $ sudo --preserve-env -s
    # mv /etc/aria2.conf /etc/aria2.conf.bak
    # mv /etc/makepkg.conf /etc/makepkg.conf.bak
    # mv /etc/pacman.conf /etc/pacman.conf.bak
    # mv /etc/powerpill/powerpill.json /etc/powerpill/powerpill.json.bak

    # stow --verbose --no-folding -t / -R aria2 makepkg pacman powerpill

Close terminal and open again

    $ sudo ln -sf /usr/bin/dash /usr/bin/sh

    $ cd ~/.dotfiles
    $ stow --verbose --no-folding -R bin bspwm dunst etc fonts mpd mpv ncmpcpp neomutt neovim picom pylint rofi scripts sublime-text-3 thunar tmux tumbler urxvt xdman yapf
