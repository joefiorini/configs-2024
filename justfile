set positional-arguments

switch *args:
    nix run github:lnl7/nix-darwin -- switch --flake ".?submodules=1" "$@"

setup-rack:
    #!/usr/bin/env fish
    cd /Volumes/music/jerps/rack
    set -x files (fd -a --max-depth 1 .)
    cd ~/Library/Application\ Support/Rack2
    for file in $files
        ln -s $file ./(basename $file)
    end
