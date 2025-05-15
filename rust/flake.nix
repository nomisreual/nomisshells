{
  description = "Simple Rust Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    rust-overlay,
  }: let
    overlays = [
      # Makes a `rust-bin` attribute available in Nixpkgs
      (import rust-overlay)
      # Provides a `rustToolchain` attribute for Nixpkgs that can be used to
      # create a Rust environment
      (self: super: {
        rustToolchain = super.rust-bin.stable.latest.default;
      })
    ];

    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = f:
      nixpkgs.lib.genAttrs allSystems (system:
        f {
          pkgs = import nixpkgs {inherit overlays system;};
        });
  in {
    packages = forAllSystems ({pkgs}: {
      default = pkgs.callPackage ./default.nix {};
    });

    devShells = forAllSystems ({pkgs}: {
      default = pkgs.callPackage ./shell.nix {};
    });
  };
}
