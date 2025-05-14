with import <nixpkgs> { };
stdenv.mkDerivation {
  name = "env";
  buildInputs =
    [ stdenv.cc.cc.lib python3Packages.gymnasium python3Packages.pygame ];
  shellHook = ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${
      pkgs.lib.makeLibraryPath [ zlib.outPath ]
    }:${pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ]}
  '';
}
