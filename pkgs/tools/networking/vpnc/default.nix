{ stdenv, fetchgit, nettools, libgcrypt, openssl, openresolv, perl, gawk, makeWrapper }:

stdenv.mkDerivation rec {
  name = "0.5.3r550-2jnpr1";
  src = fetchgit {
    url = "https://github.com/ndpgroup/vpnc.git";
    rev = "b1243d29e0c00312ead038b04a2cf5e2fa31d740";
    sha256 = "07nqbds72ixfvzyiw2r1f0vvwrmimbvfai1f0lszynh8sn3d3jba";
  };

  patches = [ ./makefile.patch ./no_default_route_when_netmask.patch ./fortigate.patch ];

  # The `etc/vpnc/vpnc-script' script relies on `which' and on
  # `ifconfig' as found in net-tools (not GNU Inetutils).
  propagatedBuildInputs = [ nettools ];

  buildInputs = [libgcrypt perl makeWrapper openssl ];

  preConfigure = ''
    sed -i 's|^#OPENSSL|OPENSSL|g' Makefile

    substituteInPlace "vpnc-script" \
      --replace "which" "type -P" \
      --replace "awk" "${gawk}/bin/awk" \
      --replace "/sbin/resolvconf" "${openresolv}/bin/resolvconf"

    substituteInPlace "config.c" \
      --replace "/etc/vpnc/vpnc-script" "$out/etc/vpnc/vpnc-script"

    substituteInPlace "pcf2vpnc" \
      --replace "/usr/bin/perl" "${perl}/bin/perl"
  '';

  postInstall = ''
    for i in "$out/{bin,sbin}/"*
    do
      wrapProgram $i --prefix PATH :  \
        "${nettools}/bin:${nettools}/sbin"
    done

    mkdir -p $out/share/doc/vpnc
    cp README nortel.txt ChangeLog $out/share/doc/vpnc/
  '';

  meta = {
    homepage = "http://www.unix-ag.uni-kl.de/~massar/vpnc/";
    description = "Virtual private network (VPN) client for Cisco's VPN concentrators";
    license = stdenv.lib.licenses.gpl2Plus;

    platforms = stdenv.lib.platforms.linux;
  };
}
