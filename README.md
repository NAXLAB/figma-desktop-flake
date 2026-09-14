# figma-desktop-flake

A Nix flake packaging the community [figma-linux](https://github.com/IliyaBrook/figma-linux)
AppImage for nix.

This flake wraps a third-party AppImage build by [IliyaBrook](https://github.com/IliyaBrook). Figma itself remains proprietary/unfree -
this flake's own packaging code is MIT licensed, but the resulting package is marked `unfree` in Nix and requires `allowUnfree`.

### Try it directly

```bash
nix run github:NAXLAB/figma-desktop-flake
```

### Add to your system flake

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
    # NixOS example
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          environment.systemPackages = [
            figma-desktop.packages.x86_64-linux.default
          ];
        }
        # ...your other modules
      ];
    };
  };
}
```

## Unfree package note

This package is marked `unfree`. Make sure unfree packages are allowed,
either in your system config:

```nix
nixpkgs.config.allowUnfree = true;
```

or by allowing just this package:

```nix
nixpkgs.config.allowUnfreePredicate = pkg:
  builtins.elem (lib.getName pkg) [ "figma-desktop" ];
```

## License

The packaging code in this repository is MIT licensed (see `LICENSE`).
Figma itself is proprietary software; this flake only automates
downloading and running the official AppImage build.