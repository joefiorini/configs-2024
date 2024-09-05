{ inputs, ... }: {
  nixpkgs.overlays = [
    (_final: _prev: {
      cartograph-cf = import ./fonts/cartograph-cf.nix _final;
      manifold-cf =
        import ./fonts/manifold-cf.nix (_final // { inputs = inputs; });
      larabiefont = import ./fonts/larabiefont.nix _final;
      recursive-sans = import ./fonts/recursive.nix _final;
    })
  ];
}
