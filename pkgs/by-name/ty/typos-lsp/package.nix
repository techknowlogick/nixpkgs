{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "typos-lsp";
  # Please update the corresponding VSCode extension too.
  # See pkgs/applications/editors/vscode/extensions/tekumara.typos-vscode/default.nix
  version = "0.1.39";

  src = fetchFromGitHub {
    owner = "tekumara";
    repo = "typos-lsp";
    tag = "v${version}";
    hash = "sha256-GMU7xWVwHleBbtCVjKWzpOvAl8JcObX/phpTphP7N5I=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-7BN+K14M4dzKP89ATA/zK1QfJxnEFD1j7kwBvvWrHQw=";

  # fix for compilation on aarch64
  # see https://github.com/NixOS/nixpkgs/issues/145726
  prePatch = ''
    rm .cargo/config.toml
  '';

  meta = with lib; {
    description = "Source code spell checker";
    homepage = "https://github.com/tekumara/typos-lsp";
    changelog = "https://github.com/tekumara/typos-lsp/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ tarantoj ];
    mainProgram = "typos-lsp";
  };
}
