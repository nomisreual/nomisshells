{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  # Get dependencies from the main package
  inputsFrom = [(pkgs.callPackage ./default.nix {})];

  # The Nix packages provided in the environment
  packages =
    (with pkgs; [
      # The package provided by our custom overlay. Includes cargo, Clippy, cargo-fmt,
      # rustdoc, rustfmt, and other tools.
      rustToolchain
    ])
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin (with pkgs; [libiconv]);
}
