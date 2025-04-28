with import <nixpkgs> { };
stdenv.mkDerivation {
  name = "env";
  buildInputs = [ python312Packages.tkinter ];
}
