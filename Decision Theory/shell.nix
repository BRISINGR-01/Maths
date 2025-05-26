with import <nixpkgs> { };
stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    (pkgs.python3.withPackages (ps: with ps; [ tkinter pyglet pygame ]))
    pkgs.SDL2
    pkgs.xorg.libX11
    pkgs.xorg.libXrandr
    pkgs.xorg.libXcursor
    pkgs.xorg.libXi
    pkgs.xorg.libXinerama
    pkgs.xorg.libXext
    pkgs.libxkbcommon
    python312Packages.opencv4
    pkgs.libGL
    pkgs.glib
    glibc
    stdenv.cc.cc.lib
    python3Packages.gymnasium
    python3Packages.pygame
    python312Packages.tkinter
    tk
  ];
  shellHook = ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${
      pkgs.lib.makeLibraryPath [ zlib.outPath ]
    }:${pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ]}:${
      pkgs.lib.makeLibraryPath [ pkgs.libGL ]
    }:${pkgs.lib.makeLibraryPath [ pkgs.glib ]}
  '';
}
