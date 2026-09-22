# NixOS guest image

Not yet implemented. The Arch spin ships first; NixOS is on the curated
roadmap and will follow.

NixOS is a special case: images are built from a Nix flake / configuration.nix
rather than mkosi or archiso. Regardless of build tool, it will ship the same
verification contract as every other curated image: a SHA-256 hash plus a
minisign signature, checked by the host app before boot.
