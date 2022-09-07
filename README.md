# Opinionated Flake templates

Highly opinionated flake templates using:

- [direnv](https://direnv.net/)
- [nix-direnv](https://github.com/nix-community/nix-direnv)
- [editorconfig](https://editorconfig.org/)
- [gitignore](https://github.com/github/gitignore)

Currently this is a work in progress and things my change a lot as I experiment
with what works best for me.

I plan on adding:

- [git hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
- [GitHub actions](https://github.com/features/actions)
- [READMEs with badges and fluff](https://shields.io/)

- nix
- R
- Julia
- C/C++

## Usage

To use, specify the template with the language and project name (destination
folder) when creating the project as follows:

```bash
nix flake new -t github:Leixb/flake-templates#<language> <ProjectName>
```

### Blank

This is the default template, it gives a simple `devShell`, some sane
default values for `.editorconfig` and `direnv` configuration.

### Python

This is an example of how to use mach-nix with flakes properly, so
that `pypi-deps-db` is managed through flake inputs and there is
no need to use `PypiDataRev` or `PypiData`.

To use the template run:

```bash
nix flake new -t github:Leixb/flake-templates#python <ProjectName>
```

You can manage the `Pypi` database using `nix flake lock`. For example, to
update the version to latest, use: `nix flake lock --update-input pypi-deps-db`

### Go

Provides a shell with `go` and several go development tools with `GOPATH` inside
`.direnv`. It also has a recipe to build a go module.

```bash
nix flake new -t github:Leixb/flake-templates#go <ProjectName>
```

### Java

Gives a shell with the latest JDK and sets up JDTLS with direnv. You
may need to tweak your IDE configuration to work with the given `JDTLS_HOME`
environment variable. For ease of use, the configuration files for `JDTLS` are
put outside the nix store so they can be freely modified if needed.

```bash
nix flake new -t github:Leixb/flake-templates#java <ProjectName>
```

It also provides a two step maven build which needs changing the values
on the `sha256` checksums manually.

### Rust

Shell with cargo, rust-analyzer and other rust tooling.

```bash
nix flake new -t github:Leixb/flake-templates#rust <ProjectName>
```

### R

R with tidyverse and languageserver

```bash
nix flake new -t github:Leixb/flake-templates#R <ProjectName>
```

### LaTeX

LaTeX template using [Leixb/latex-template](https://github.com/Leixb/latex-template).
Already includes latex files to get going quickly.

```bash
nix flake new -t github:Leixb/flake-templates#latex <ProjectName>
```

### Lua

Lua with sumneko-lua-language-server.

```bash
nix flake new -t github:Leixb/flake-templates#lua <ProjectName>
```
