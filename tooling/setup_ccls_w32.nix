{ pkgs ? import <nixpkgs> {} }:

let
  mingw = pkgs.pkgsCross.mingw32;
in
pkgs.mkShell {
  buildInputs = [
    mingw.buildPackages.gcc
    pkgs.ccls
  ];

  shellHook = ''
    echo "Windows headers are at: ${mingw.windows.mingw_w64_headers}/include"
    cat > .ccls <<EOF
%c -std=c11
%cpp -std=c++17
%h %hpp --include=Global.h
-I${mingw.windows.mingw_w64_headers}/include
--target=x86_64-w64-mingw32
EOF
  '';
}
