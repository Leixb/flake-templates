{
  description = ''
    Opinionated flake templates for different developement environments.

    Use `nix flake new -t github:leixb/flate-templates#language` to use the template
  '';
  outputs = self: rec {
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

      golang = templates.go;

      java = {
        path = ./java-maven;
        description = "Java template using maven and JDTLS";
      };

      rust = {
        path = ./rust;
        description = "Rust template";
      };

      R = {
        path = ./R;
        description = "R template";
      };

      r = templates.R;

      latex = {
        path = ./latex;
        description = "LaTeX template";
      };

      lua = {
        path = ./lua;
        description = "Lua template";
      };
    };

    defaultTemplate = templates.blank;
  };
}
