{
  description = "Gymnasium LunarLander environment on Hyprland (Wayland)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        pythonEnv = pkgs.python3.withPackages
          (ps: with ps; [ gymnasium pygame matplotlib numpy ]);
      in {
        devShells.default = pkgs.mkShell {
          buildInputs =
            [ pythonEnv pkgs.xorg.libX11 pkgs.xorg.xwayland pkgs.SDL2 ];

          shellHook = ''
            export SDL_VIDEODRIVER=x11
            echo "SDL_VIDEODRIVER set to x11 for Gym UI on Hyprland."
          '';
        };
      });
}
