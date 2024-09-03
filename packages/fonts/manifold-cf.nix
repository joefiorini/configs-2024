{ stdenv, ... }:
stdenv.mkDerivation rec {
  pname = "Manifold CF";
  version = "4.3";
  src = ../../. + builtins.toPath "/resources/fonts/manifold-cf";

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}

