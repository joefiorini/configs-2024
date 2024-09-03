{ stdenv, ... }:
stdenv.mkDerivation rec {
  name = "LarabieFont";
  src = ../../. + builtins.toPath "/resources/fonts/larabiefont";

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}

