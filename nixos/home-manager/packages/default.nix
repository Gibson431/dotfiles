{pkgs ? import <nixpkgs> {}}: let
  currentDir = ./.;
  readDir = builtins.readDir currentDir;

  isDirectory = name: type: type == "directory";

  directories = builtins.filter (name: type: isDirectory name (builtins.getAttr name readDir)) (builtins.attrNames readDir);

  importIfExists = dir: let
    defaultNixPath = "${dir}/default.nix";
  in
    if builtins.pathExists defaultNixPath
    then import defaultNixPath
    else {};

  packages = builtins.map importIfExists directories;
in {
  inherit packages;
}
