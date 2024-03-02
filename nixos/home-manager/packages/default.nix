{
  pkgs,
  lib,
  ...
}:
with lib; let
  currentDir = ./.;
  files = dir:
    lib.attrsets.mapAttrsToList
    (name: value:
      if value == "directory"
      then "${name}"
      else null)
    (builtins.readDir dir);

  packages = dir: filter (file: ! isNull file) (files dir);

  importDirectory = dir: let
    dirPath = "${currentDir}/${dir}";
  in
    if builtins.pathExists dirPath
    then import dirPath
    else {};

  importedPackages = dir: builtins.map importDirectory (packages dir);
in {
  imports = importedPackages ./.;
}
