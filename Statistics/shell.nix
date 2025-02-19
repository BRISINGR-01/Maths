{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  buildInputs = [ pkgs.gcc ];

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/nix/store/l6s0g4rpf82i933xk8y15cs5w0im79mw-gcc-14.2.0-lib/lib/"
    poetry run fish -c "jupyter-notebook"
  '';
}
