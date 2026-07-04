return {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', '.git' },
  settings = {
    nixd = {
      options = {
        nixos = {
          expr = '(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.EncoreNix.options'
        },
        home_manager = {
          expr =
          '(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.EncoreNix.options.home-manager.users.type.getSubOptions []'
        },
      },
    },
  },
}
