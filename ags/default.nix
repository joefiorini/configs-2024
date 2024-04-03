{ inputs, esbuild, writeShellScript, system, stdenv, ... }:
let
  ags = inputs.ags.packages.${system}.default;
  name = "spaceballs-the-desktop";
  # desktop = stdenv.writeShellScript name ''
  #   ${inputs.ags}/bin/ags -b ${name} -c ${config}/config.js $@
  # '';
  desktop = writeShellScript name ''
    ${ags}/bin/ags -b ${name} -c ${config}/config.js $@
  '';
  config = stdenv.mkDerivation {
    inherit name;
    src = ./.;

    buildPhase = ''
      ${esbuild}/bin/esbuild \
        --bundle ./main.ts \
        --outfile=main.js \
        --format=esm \
        --external:resource://\* \
        --external:gi://\* \

    '';

    installPhase = ''
      mkdir -p $out
      # cp -r assets $out
      # cp -r style $out
      # cp -r greeter $out
      # cp -r widget $out
      cp -f main.js $out/config.js
    '';
  };

in stdenv.mkDerivation {
  inherit name;
  src = config;

  installPhase = ''
    mkdir -p $out/bin
    cp -r . $out
    cp ${desktop} $out/bin/${name}
  '';
}
