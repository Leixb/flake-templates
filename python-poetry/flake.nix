{
  description = "Python environment managed with poetry and flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

  };
  outputs = { self, nixpkgs, flake-utils, pre-commit-hooks, poetry2nix }:

  {
        overlay = nixpkgs.lib.composeManyExtensions [
        poetry2nix.overlay
        (final: prev: {
          # The application
          myapp = prev.poetry2nix.mkPoetryApplication {
            projectDir = ./.;
          };
        })
      ];
    } // flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlay ];
    };

    addBuildInput = { drv, self, super, input }:
      super.${drv}.overridePythonAttrs ( old: { nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ self.${input} ]; });

    overrides = pkgs.poetry2nix.overrides.withDefaults (self: super: {
      nbconvert = addBuildInput { drv = "nbconvert"; input = "hatchling"; inherit self super; };
    });

    python = pkgs.python38;

    pyEnv = pkgs.poetry2nix.mkPoetryEnv {
      projectDir = ./.;
      inherit python overrides;
    };

  in {

    checks = {
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          black.enable = true;
          isort.enable = true;
        };
      };
    };

    devShells.default = pkgs.mkShell {
      name = "python";

      LD_LIBRARY_PATH= pkgs.lib.strings.makeLibraryPath (with pkgs;[ stdenv.cc.cc.lib zlib ]);

      buildInputs = [
        pyEnv # Uncomment to build the environment with nix
        # python.pkgs.poetry
      ];

      inherit (self.checks.${system}.pre-commit-check) shellHook;
    };
  });
}
