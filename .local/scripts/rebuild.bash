set -e
pushd ~/dotfiles/nixos/
nvim .
alejandra . &>/dev/null
git diff -U0 *.nix
echo "NixOS Rebuilding ... "
sudo nixos-rebuild switch --flake .
# sudo nixos-rebuild switch --flake . &>nixos-switch.log || (cat nixos-switch.log | grep --color error && false)
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
popd