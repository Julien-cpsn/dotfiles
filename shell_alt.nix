{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.bison
    pkgs.flex
    pkgs.fontforge
    pkgs.makeWrapper
    pkgs.pkg-config
    pkgs.gnumake
    pkgs.gcc
    pkgs.libiconv
    pkgs.autoconf
    pkgs.automake
    pkgs.libtool
  ];
}
