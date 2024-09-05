{ stdenv, ... }:
stdenv.mkDerivation {
  name = "LarabieFont";
  src = ../../. + builtins.toPath "/resources/fonts/Larabiefont";

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}

