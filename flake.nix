{
  description = "Blaix Tools and Stuff";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";

  outputs = { nixpkgs, ... }: {
    packages = builtins.mapAttrs (system: pkgs: {
      serve-static = pkgs.callPackage ./pkgs/serve-static.nix {};
      worktree = pkgs.callPackage ./pkgs/worktree.nix {};
      worktree-rm = pkgs.callPackage ./pkgs/worktree-rm.nix {};
    }) nixpkgs.legacyPackages;
  };
}
