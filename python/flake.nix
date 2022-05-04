{
  description = "Python environment managed with mach-nix and flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # use `nix flake lock --update-input pypi-deps-db` to update the pypi database
    # or `nix flake update` to update all
    pypi-deps-db = {
      url = "github:DavHau/pypi-deps-db";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.mach-nix.follows = "mach-nix";
    };

    mach-nix = {
      url = "github:DavHau/mach-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.pypi-deps-db.follows = "pypi-deps-db";
    };

  };
  outputs = { nixpkgs, flake-utils, mach-nix, ...}:

  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs { inherit system; };

    # Do NOT use import mach-nix {inherit system;};
    #
    # otherwise mach-nix will not use flakes and pypi-deps-db
    # input will not be used:
    # https://github.com/DavHau/mach-nix/issues/269#issuecomment-841824763
    mach = mach-nix.lib.${system};

    python-env = mach.mkPython {
      # Choose python version
      python = "python39";

      # Specify python requirements, you can use ./requirements.txt a
      # string (or a combination of both)
      requirements = ''
        ipython
        python-lsp-server
        python-language-server[all]
      '' + (builtins.readFile ./requirements.txt);
    };

  in
  {
    devShell = pkgs.mkShellNoCC {
      name = "python";
      buildInputs = [ python-env ];
    };
  });
}
