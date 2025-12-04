# My dotfiles

## How to use

1. Install git
2. Clone the repository
3. Install Nix
```shell
sh <(curl -L https://nixos.org/nix/install) --daemon
```
4. Install Home manager
```shell
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-25.05 nixpkgs
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
nix-shell '<home-manager>' -A install
```
5. Copy the `home.nix` file into the `.config/home-manager/` directory
```shell
cp home.nix ~/.config/home-manager/home.nix
```
6. Build and switch your Home manager
```
home-manager build
home-manager switch
```
7. Allow ZSH
```shell
sudo sh -c "echo $(which zsh) >> /etc/shells"
```
8. Change shell
```shell
chsh -s $(which zsh)
```
