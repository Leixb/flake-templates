{
  description = "Cargo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = pkgs.mkShell {
          name = "rust";
          buildInputs = with pkgs; [
            cargo
            cargo-edit
            cargo-release
            rust-analyzer
            rustc
            rustfmt
          ];
        };
      }
    );
}
