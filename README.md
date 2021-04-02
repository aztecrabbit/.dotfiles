          /\        aztecrabbit@home
         /  \       ----------------
        /\   \      OS: Arch Linux x86_64
       /      \     WM: bspwm
      /   ,,   \    Shell: zsh
     /   |  |  -\   Terminal: st
    /_-''    ''-_\  


Packages
--------

| Name                             | Description |
| ----                             | ----------- |
| antigen-git                      | Plugin manager for zsh, inspired by oh-my-zsh and vundle |
| aria2                            | Download utility that supports HTTP(S), FTP, BitTorrent, and Metalink |
| bspwm-git                        | Tiling Window Manager based on binary space partitioning |
| dmenu                            | Generic menu for X |
| dunst                            | Customizable and lightweight notification-daemon |
| ecryptfs-utils                   | Enterprise-class stacked cryptographic filesystem for Linux |
| ffscreencast                     | ffmpeg screencast/desktop-recording with video overlay and multi monitor support |
| gtk-youtube-viewer-git           | GTK+ application for searching and streaming videos from YouTube |
| gucharmap                        | Gnome Unicode Charmap |
| libxft-bgra                      | libXft with BGRA glyph (color emoji) rendering & scaling patches by Maxime Coste |
| lxappearance                     | Feature-rich GTK+ theme switcher of the LXDE Desktop |
| matcha-gtk-theme                 | A flat design theme for GTK 3, GTK 2 and GNOME Shell |
| megacmd                          | MEGA Command Line Interactive and Scriptable Application |
| mpc                              | Minimalist command line interface to MPD |
| mpd                              | Flexible, powerful, server-side application for playing music |
| mpv                              | Free, open source, and cross-platform media player |
| ncmpcpp                          | Almost exact clone of ncmpc (Fully featured MPD client using ncurses) with some new features |
| papirus-icon-theme               | Papirus icon theme |
| picom                            | X compositor that may fix tearing issues |
| polybar-git                      | Fast and easy-to-use status bar |
| powerpill                        | Pacman wrapper for faster download |
| rofi                             | Window switcher |
| scrot                            | Simple command-line screenshot utility for X |
| stow                             | Manage installation of multiple softwares in the same directory tree |
| sxhkd-git                        | Simple X hotkey daemon |
| tmux                             | Terminal multiplexer |
| ttf-dejavu                       | Font family based on the Bitstream Vera Fonts with a wider range of characters |
| ttf-font-awesome                 | Iconic font designed for Bootstrap |
| ttf-joypixels                    | Emoji as a Service (formerly EmojiOne) |
| ttf-material-design-icons        | Material Design icons by Google |
| ttf-nerd-fonts-hack-complete-git | A typeface designed for source code. Patched with Nerd Fonts iconics |
| unrar                            | RAR uncompression program |
| vim                              | Vi Improved, a highly configurable, improved version of the vi text editor |
| wmname                           | Utility to set the name of your window manager |
| xclip                            | Command line interface to the X11 clipboard |
| xcursor-breeze                   | Breeze cursor theme (KDE Plasma 5). This package is for usage in non-KDE Plasma desktops |
| xdman                            | Powerful tool to increase download speed up-to 500% |
| xdo                              | Utility for performing actions on windows in X |
| zscroll-git                      | Horizontal text scroller for use with panels |
| zsh                              | Very advanced and programmable command interpreter (shell) for UNIX |


Multithreading Package Manager
------------------------------

Install required packages

    $ yay -S aria2 powerpill

Change to root

    $ sudo --preserve-env -s

Backup default config

    # mv -f /etc/aria2.conf /etc/aria2.conf.bak
    # mv -f /etc/makepkg.conf /etc/makepkg.conf.bak
    # mv -f /etc/pacman.conf /etc/pacman.conf.bak
    # mv -f /etc/powerpill/powerpill.json /etc/powerpill/powerpill.json.bak

Stow required config file

    # stow --verbose --no-folding -t / -R aria2 makepkg pacman powerpill


Usage
-----

Run this command if you want to download packages using multithreading mode

    $ sudo powerpill -S package-name

or

    $ yay --pacman powerpill -S package-name

or just use my dotfiles for terminal [here](https://github.com/aztecrabbit/.dotfiles-terminal) :D
