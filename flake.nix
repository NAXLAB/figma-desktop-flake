{
  description = "Unofficial Figma desktop client by IliyaBrook packaged as a flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      figma-desktop = pkgs.callPackage ./figma-desktop.nix { };
    in
    {
      packages.${system} = {
        default = figma-desktop;
        figma-desktop = figma-desktop;
      };
    };
}