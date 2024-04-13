{ inputs, ... }:

{
  imports = [ inputs.pre-commit-hooks.flakeModule ];

  perSystem.pre-commit = {
    settings.excludes = [ "flake.lock" ];

    settings.hooks = {
      end-of-file-fixer.enable = true;
      trim-trailing-whitespace.enable = true;

      nixfmt.enable = true;
    };
  };
}
