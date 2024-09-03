{ stdenv, fetchzip, ... }:
stdenv.mkDerivation rec {
  pname = "Recursive Sans & Mono";
  version = "1.085";
  src = fetchzip {
    url =
      "https://github.com/arrowtype/recursive/releases/download/v${version}/ArrowType-Recursive-${version}.zip";
    hash = "sha256-hnGnKnRoQN8vFStW8TjLrrTL1dWsthUEWxfaGF0b0vM=";
  };

  installPhase = ''
    rm README.md
    mkdir -p $out
    cp -r * $out
  '';
}

