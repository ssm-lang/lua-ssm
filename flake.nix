# Hacky Nix flake for Lua development.
#
# I still need to set this up for building packages, but I'll come back to that
# once I figure out the story with doing that Nix-less first.
#
# For now, I'm just using this for dropping into a dev shell:
#
#   $ nix develop
#   $ eval $(luarocks path)
#   $ luarocks build --local
#   $ cd examples
#   $ lua <example>.lua
#
# Yeah I know this is an abuse of nix and that there's a better dev setup.
# I'll get to that later.
{
  description = "lua-ssm";

  inputs.nixpkgs.url = "nixpkgs/nixos-22.11";

  outputs = { self, nixpkgs }:
    let
      # Adapted from: https://xeiaso.net/blog/nix-flakes-1-2022-02-21
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

      luaVersions = [ "lua5_1" "lua5_2" "lua5_3" "lua5_4" "luajit" ];
      luaDefault = "luajit";
      forAllLuaVersions = nixpkgs.lib.genAttrs luaVersions;
    in
    {
      devShells = forAllSystems (system:
        let
          shells = forAllLuaVersions (luaVersion:
            let
              pkgs = nixpkgsFor.${system};
              luaPackages = pkgs.${luaVersion}.pkgs;
            in
            pkgs.mkShell {
              buildInputs = with pkgs; [
                luaPackages.luarocks
                luaPackages.luv
              ];
            })
          ;
        in
        shells // { default = shells.${luaDefault}; }
      );
    };
}
