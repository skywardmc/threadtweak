{
  description = "Improve and tweak Minecraft CPU scheduling (again!)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});

    forEachSystem = fn:
      forAllSystems (system:
        fn {
          inherit system;
          pkgs = nixpkgsFor.${system};
        });
  in {
    devShells = forEachSystem ({pkgs, ...}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          jdk17_headless
          gradle_7
        ];
      };
    });

    formatter = forEachSystem ({pkgs, ...}: pkgs.alejandra);
  };
}
