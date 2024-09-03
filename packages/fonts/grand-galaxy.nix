{ stdenv }:
stdenv.mkDerivation rec {
  pname = "Grand Galaxy";
  src = ../../. + builtins.toPath "/resources/fonts/grand-galaxy";

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}

