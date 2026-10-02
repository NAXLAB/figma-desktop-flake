{
  description = "Unofficial Figma desktop client by IliyaBrook packaged as a flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    figma-appimage = {
      url = "file+https://github.com/IliyaBrook/figma-linux/releases/download/126.5.6/figma-desktop-126.5.6-amd64.AppImage";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, figma-appimage }:
    let
      system = "x86_64-linux";
      version = "126.5.6"; # keep in sync with the input URL above

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      figma-desktop = pkgs.callPackage ./figma-desktop.nix {
        src = figma-appimage;
        inherit version;
      };
    in
    {
      packages.${system} = {
        default = figma-desktop;
        inherit figma-desktop;
      };

      nixosModules.default = {
        environment.systemPackages = [ figma-desktop ];
      };
    };
}