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
| aria2c-daemon                   | Daemonize aria2c |
| bspwm-git                       | Tiling Window Manager based on binary space partitioning |
| dmenu                           | Generic menu for X |
| dunst                           | Customizable and lightweight notification-daemon |
| ecryptfs-utils                  | Enterprise-class stacked cryptographic filesystem for Linux |
| ffscreencast                    | ffmpeg screencast/desktop-recording with video overlay and multi monitor support |
| gtk-youtube-viewer-git          | GTK+ application for searching and streaming videos from YouTube |
| gucharmap                       | Gnome Unicode Charmap |
| lxappearance                    | Feature-rich GTK+ theme switcher of the LXDE Desktop |
| megacmd-bin                     | MEGA Command Line Interactive and Scriptable Application |
| mpc                             | Minimalist command line interface to MPD |
| mpd                             | Flexible, powerful, server-side application for playing music |
| mpv                             | Free, open source, and cross-platform media player |
| ncmpcpp                         | Almost exact clone of ncmpc (Fully featured MPD client using ncurses) with some new features |
| pgcli                           | Command line interface for Postgres with auto-completion and syntax highlighting |
| picom                           | X compositor that may fix tearing issues |
| polybar                         | Fast and easy-to-use status bar |
| powerpill                       | Pacman wrapper for faster download |
| rofi                            | Window switcher |
| scrot                           | Simple command-line screenshot utility for X |
| stow                            | Manage installation of multiple softwares in the same directory tree |
| sxhkd-git                       | Simple X hotkey daemon |
| tmux                            | Terminal multiplexer |
| ttf-font-awesome                | Iconic font designed for Bootstrap |
| ttf-material-design-icons       | Material Design icons by Google |
| unrar                           | RAR uncompression program |
| vim                             | Vi Improved, a highly configurable, improved version of the vi text editor |
| wmname                          | Utility to set the name of your window manager |
| xclip                           | Command line interface to the X11 clipboard |
| xdman                           | Powerful tool to increase download speed up-to 500% |
| xdo                             | Utility for performing actions on windows in X |
| zscroll-git                     | Horizontal text scroller for use with panels |
| zsh                             | Very advanced and programmable command interpreter (shell) for UNIX |

    $ yay -S antigen-git aria2 aria2c-daemon bspwm-git dmenu dunst ecryptfs-utils ffscreencast gtk-youtube-viewer-git gucharmap lxappearance megacmd-bin mpc mpd mpv ncmpcpp pgcli picom polybar powerpill rofi scrot stow sxhkd-git tmux ttf-font-awesome ttf-material-design-icons unrar vim wmname xclip xdman xdo zscroll-git zsh


Termux
------

    $ apt install stow zsh
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

    $ cd ~/.dotfiles
    $ stow --verbose --no-folding -R bin bspwm dunst etc fonts mpd mpv ncmpcpp picom pylint rofi scripts thunar tmux tumbler urxvt xdman yapf
