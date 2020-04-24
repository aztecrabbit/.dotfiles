
    # curl -L https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh > ~/.antigen.zsh
    yay -S antigen-git
    yay -S ttf-font-awesome
    yay -S ttf-material-design-icons

<!-- -->

    stow --verbose --no-folding -R zsh

    sudo stow --verbose --no-folding -t / -R aria2
    sudo stow --verbose --no-folding -t / -R pacman
    sudo stow --verbose --no-folding -t / -R makepkg
    sudo stow --verbose --no-folding -t / -R powerpill

