{
  stdenv,
  lib,
  gitaly,
  fetchFromGitLab,
  curl,
  pcre2,
  zlib,
}:

stdenv.mkDerivation rec {
  pname = "gitaly-git";
  version = "2.49.0.gl2";

  # `src` attribute for nix-update
  src = fetchFromGitLab {
    owner = "gitlab-org";
    repo = "git";
    rev = "v${version}";
    hash = "sha256-1y94T5UBG7s76ENsUmaXRXngSKmqIAT0nq1u+QjSWaY=";
  };

  # we actually use the gitaly build system
  unpackPhase = ''
    cp -r ${gitaly.src} source
    chmod -R +w source

    mkdir -p source/_build/deps

    cp -r ${src} source/_build/deps/git-distribution
    chmod -R +w source/_build/deps/git-distribution

    # FIXME? maybe just patch the makefile?
    echo -n 'v${version} DEVELOPER=1 DEVOPTS=no-error USE_LIBPCRE=YesPlease NO_PERL=YesPlease NO_EXPAT=YesPlease NO_TCLTK=YesPlease NO_GETTEXT=YesPlease NO_PYTHON=YesPlease' > source/_build/deps/git-distribution.version
    echo -n 'v${version}' > source/_build/deps/git-distribution/version
  '';
  sourceRoot = src.name;

  buildFlags = [ "git" ];

  buildInputs = [
    curl
    pcre2
    zlib
  ];

  # The build phase already installs it all
  GIT_PREFIX = placeholder "out";
  dontInstall = true;

  meta = {
    homepage = "https://git-scm.com/";
    description = "Distributed version control system - with Gitaly patches";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.all;
    teams = [ lib.teams.gitlab ];
  };
}
