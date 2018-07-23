{ stdenv, fetchFromGitHub, pkgconfig, libxcb, xcbutilkeysyms, libX11, i3ipc-glib, glib }:

stdenv.mkDerivation rec {
  version = "03-20-2018";
  name = "i3-easyfocus-${version}";

  src = fetchFromGitHub {
    owner = "cornerman";
    repo = "i3-easyfocus";
    rev = "3631d5af612d58c3d027f59c86b185590bd78ae1";
    sha256 = "1wgknmmm7iz0wxsdh29gmx4arizva9101pzhnmac30bmixf3nzhr";
  };

  nativeBuildInputs = [ pkgconfig ];

  buildInputs = [
    libxcb
    xcbutilkeysyms
    libX11
    libxcb
    i3ipc-glib
    glib
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./i3-easyfocus $out/bin
  '';
}
