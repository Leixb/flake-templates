# Simple mach-nix template with flakes

This is an example of how to use mach-nix with flakes properly, so
that `pypi-deps-db` is managed through flake inputs and there is
no need to use `PypiDataRev` or `PypiData`.

To use the template run:

```bash
nix flake template new -t github:leixb/mach-nix-flake <ProjectName>
```

You can manage the `Pypi` database using `nix flake lock`. For example, to
update the version to latest, use: `nix flake lock --update-input pypi-deps-db`
