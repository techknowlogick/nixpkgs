{ callPackage }:
callPackage ./generic.nix { } rec {
  pname = "signal-desktop-beta";
  dir = "Signal Beta";
  version = "7.29.0-beta.1";
  url = "https://updates.signal.org/desktop/apt/pool/s/signal-desktop-beta/signal-desktop-beta_${version}_amd64.deb";
  hash = "sha256-+IfCdwoDgHgqOKS7QAca0P3ULw8EE40asqJvj2zWWPA=";
}
