# figma-desktop-flake

A Nix flake packaging the community [figma-linux](https://github.com/IliyaBrook/figma-linux)
AppImage for Nix.

This flake wraps a third-party AppImage build by [IliyaBrook](https://github.com/IliyaBrook).
Figma itself remains proprietary/unfree. This flake's own packaging code is MIT licensed.

## Try it directly

```bash
nix run github:NAXLAB/figma-desktop-flake
```

## Add to your NixOS config

Add the flake as an input and import its module:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    figma-desktop = {
      url = "github:NAXLAB/figma-desktop-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, figma-desktop, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        figma-desktop.nixosModules.default
        # ...your other modules
      ];
    };
  };
}
```

Importing the module installs Figma system-wide. No extra options are needed.

### Without the module

If you'd rather install the package yourself (for example in `home.packages`
or a dev shell), it's exposed as `packages.x86_64-linux.default`:

```nix
environment.systemPackages = [
  figma-desktop.packages.x86_64-linux.default
];
```

## Unfree note

The package is marked `unfree` in Nix, but the flake builds it with
`allowUnfree` enabled, so you do **not** need to change your own
`nixpkgs.config`.

## Updating

```bash
nix flake update figma-desktop
```

## License

The packaging code in this repository is MIT licensed (see `LICENSE`).
Figma is proprietary software owned by Figma, Inc. This flake only packages
the community-built figma-linux AppImage.