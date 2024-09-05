{ stdenv, inputs, ... }:
stdenv.mkDerivation {
  pname = "Manifold CF";
  version = "4.3";
  src = "${inputs.resources}/fonts/manifold-cf";

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}

