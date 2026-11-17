{
  description = "ncrypt command-line stream encryption";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
    in
    {
      packages = nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          ncrypt = pkgs.buildGoModule {
            pname = "ncrypt";
            version = "unstable";

            src = self;
            vendorHash = "sha256-BbxwfJGk6YVSEmstbhqHWbjXQ37i6Lhffq2C8SQ/480=";
            subPackages = [ "cmd/ncrypt" ];

            meta = {
              description = "Encrypt and decrypt data streams using the DARE format";
              homepage = "https://github.com/nikvdp/sio";
              license = pkgs.lib.licenses.asl20;
              mainProgram = "ncrypt";
              platforms = systems;
            };
          };
        in
        {
          inherit ncrypt;
          default = ncrypt;
        });
    };
}
