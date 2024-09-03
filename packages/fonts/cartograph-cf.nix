{ stdenv, ... }:
stdenv.mkDerivation rec {
  pname = "Cartograph CF";
  version = "2.9.4";
  src = ../../. + builtins.toPath "/resources/fonts/cartograph-cf";

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
