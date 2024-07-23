{
  pkgs ? import nixpkgs {
    inherit system;
    config = { };
    overlays = [ ];
  },
  lib ? pkgs.lib,
  nixpkgs ? <nixpkgs>,
  system ? builtins.currentSystem,
}:
pkgs.mkShellNoCC {
  packages = [
    pkgs.jdk21_headless
    pkgs.gradle_8
  ];
}
