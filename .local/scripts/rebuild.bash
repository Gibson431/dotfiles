set -e
pushd ~/dotfiles/nixos/
nvim .
alejandra . &>alejandra.log || (cat alejandra.log && false)
git diff -U0 *.nix
echo "NixOS Rebuilding ... "
git add .
git commit -am "temp commit" &>/dev/null
if sudo nixos-rebuild switch --flake . &>nixos-switch.log; then
	gen=$(nixos-rebuild list-generations | grep current)
	git reset HEAD~
	git commit -am "$gen"
else
	git reset HEAD~
	(cat nixos-switch.log | grep --color error && false)
	false
fi
# sudo nixos-rebuild switch --flake . &>nixos-switch.log || (cat nixos-switch.log | grep --color error && false)
popd
