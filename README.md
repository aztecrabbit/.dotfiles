          /\        aztecrabbit@home
         /  \       ----------------
        /\   \      OS: Arch Linux x86_64
       /      \     WM: xmonad
      /   ,,   \    Shell: zsh
     /   |  |  -\   Terminal: alacritty
    /_-''    ''-_\  


Packages
--------

| Name                             | Description |
| ----                             | ----------- |
| aria2                            | Download utility that supports HTTP(S), FTP, BitTorrent, and Metalink |
| dmenu                            | Generic menu for X |
| dunst                            | Customizable and lightweight notification-daemon |
| ecryptfs-utils                   | Enterprise-class stacked cryptographic filesystem for Linux |
| ffscreencast                     | ffmpeg screencast/desktop-recording with video overlay and multi monitor support |
| gucharmap                        | Gnome Unicode Charmap |
| lxappearance                     | Feature-rich GTK+ theme switcher of the LXDE Desktop |
| matcha-gtk-theme                 | A flat design theme for GTK 3, GTK 2 and GNOME Shell |
| megacmd                          | MEGA Command Line Interactive and Scriptable Application |
| mpc                              | Minimalist command line interface to MPD |
| mpd                              | Flexible, powerful, server-side application for playing music |
| mpv                              | Free, open source, and cross-platform media player |
| ncmpcpp                          | Almost exact clone of ncmpc (Fully featured MPD client using ncurses) with some new features |
| papirus-icon-theme               | Papirus icon theme |
| picom                            | X compositor that may fix tearing issues |
| powerpill                        | Pacman wrapper for faster download |
| rofi                             | Window switcher |
| scrot                            | Simple command-line screenshot utility for X |
| stow                             | Manage installation of multiple softwares in the same directory tree |
| tmux                             | Terminal multiplexer |
| ttf-dejavu                       | Font family based on the Bitstream Vera Fonts with a wider range of characters |
| ttf-joypixels                    | Emoji as a Service (formerly EmojiOne) |
| unrar                            | RAR uncompression program |
| vim                              | Vi Improved, a highly configurable, improved version of the vi text editor |
| wmname                           | Utility to set the name of your window manager |
| xclip                            | Command line interface to the X11 clipboard |
| xcursor-breeze                   | Breeze cursor theme (KDE Plasma 5). This package is for usage in non-KDE Plasma desktops |
| xdman                            | Powerful tool to increase download speed up-to 500% |
| xdo                              | Utility for performing actions on windows in X |
| xmobar                           | Minimalistic Text Based Status Bar |
| xmonad                           | Lightweight X11 tiled window manager written in Haskell |
| xmonad-contrib                   | Add-ons for xmonad |
| zscroll-git                      | Horizontal text scroller for use with panels |
| zsh                              | Very advanced and programmable command interpreter (shell) for UNIX |


Multithreading Package Manager
------------------------------

Install required packages

    $ yay -S git stow aria2 powerpill

Clone this repo

    $ git clone https://github.com/aztecrabbit/.dotfiles ~/.dotfiles

Go to this repo folder

    $ cd ~/.dotfiles

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

or just use zsh dotfile from my dotfiles terminal [here](https://github.com/aztecrabbit/.dotfiles-terminal) :D
