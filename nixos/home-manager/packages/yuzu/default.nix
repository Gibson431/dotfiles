{pkgs, ...}: {
  home.packages = [
    pkgs.yuzuPackages.mainline
  ];
}
