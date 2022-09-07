{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = { self, nixpkgs, flake-utils }:

  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      R-dev = pkgs.rWrapper.override {
        packages = with pkgs.rPackages; [
          languageserver
          tidyverse
        ];
      };
    in {
      devShell = with pkgs; mkShellNoCC {
        name = "R";
        buildInputs = [
          R-dev
        ];

        # If for some reason you need to install
        # packages manually
        shellHook = ''
          mkdir -p "$(pwd)/_libs"
          export R_LIBS_USER="$(pwd)/_libs"
        '';
      };
    });
}
