{
  description = ''
    Use `nix flake new -t github:leixb/mach-nix-flake` to use the template
  '';
  outputs = self: {
    templates = {
      python = {
        path = ./template;
        description = "Python template using mach-nix and flakes";
      };
    };
    defaultTemplate = self.templates.python;
  };
}
