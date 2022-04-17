{
  description = ''
    Opinionated flake templates for different developement environments.

    Use `nix flake new -t github:leixb/flate-templates#language` to use the template
  '';
  outputs = self: {
    templates = {

      blank = {
        path = ./blank;
        description = "Base template";
      };

      python = {
        path = ./python;
        description = "Python template using mach-nix and flakes";
      };

      go = {
        path = ./go;
        description = "Golang template";
      };

      golang = self.templates.go;

      java = {
        path = ./java-maven;
        description = "Java template using maven and JDTLS";
      };

    };
    defaultTemplate = self.templates.blank;
  };
}
