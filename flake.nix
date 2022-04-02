{
  description = ''
    Use `nix flake new -t github:leixb/mach-nix-flake` to use the template
  '';
  outputs = rec {
    templates = {
      python = {
        path = ./template;
        description = "Python template using mach-nix and flakes";
      };
    };
    defaultTemplate = templates.python;
  };
}
