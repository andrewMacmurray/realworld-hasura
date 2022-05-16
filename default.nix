{ pkgs ? import <nixpkgs> { } }:
let
  easy-ps = import
    (pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "9a44ddfad868fe804e22973d32839c2f2167571c";
      sha256 = "0dz6q8qyldbkzyma1fw7p44zm493hs4jxxzr7ll1h36z8i6k38xq";
    }) {
    inherit pkgs;
  };
in
pkgs.mkShell {
  buildInputs = [
    easy-ps.purs-0_13_8
    easy-ps.spago
    easy-ps.purty
  ];
}