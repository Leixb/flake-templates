{
  description = ''
    Opinionated flake templates for different developement environments.

    Use `nix flake new -t github:leixb/flate-templates#language` to use the template
  '';
  outputs = self: {
    templates = {

      python = {
        path = ./python;
        description = "Python template using mach-nix and flakes";
      };

      go = {
        path = ./go;
        description = "Golang template";
      };

      golang = self.templates.go;

    };
    defaultTemplate = self.templates.python;
  };
}
