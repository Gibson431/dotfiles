{ pkgs, ... }:
with pkgs;
let
  tools = [
    python312
    python312Packages.pip
    python312Packages.setuptools
    python312Packages.python-lsp-server
  ];
  packages = [ graphviz python312Packages.numpy python312Packages.tkinter tk ];
in { environment.systemPackages = tools ++ packages; }
