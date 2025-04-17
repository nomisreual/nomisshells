{
  description = "Simple Python Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    allSystems = [
      "x86_64-linux" # 64-bit Intel/AMD Linux
      "aarch64-linux" # 64-bit ARM Linux
      "x86_64-darwin" # 64-bit Intel macOS
      "aarch64-darwin" # 64-bit ARM macOS
    ];

    # Helper to provide system-specific attributes
    forAllSystems = f:
      nixpkgs.lib.genAttrs allSystems (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
          };
        });
  in {
    devShells = forAllSystems ({pkgs}: {
      default = let
        python = pkgs.python311;
      in
        pkgs.mkShell {
          packages =
            [
              (python.withPackages (ps:
                with ps; [
                  # python packages
                  django
                ]))
            ]
            ++ (with pkgs; [
              # other packages
            ]);
        };
    });
  };
}
