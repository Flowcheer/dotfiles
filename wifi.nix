{ stdenv, lib, fetchFromGitHub, kernel, kmod }:

stdenv.mkDerivation rec {
  pname = "rtl8188eus";
  version = "5.3.9";

  src = fetchFromGitHub {
    owner = "gglluukk";
    repo = "rtl8188eus";
    rev = "v${version}";
    hash = "sha256-nIo/jHp2jQmHJPsGiJjJEpMSk+i1BrW+cYGUqfmLexE=";
  };

  hardeningDisable = [ "pic" "format" ];                                             # 1
  nativeBuildInputs = kernel.moduleBuildDependencies;                       # 2

  prePatch = ''
    substituteInPlace ./Makefile \
      --replace /lib/modules/ "${kernel.dev}/lib/modules/" \
      --replace /sbin/depmod \# \
      --replace '$(MODDESTDIR)' "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
  '';

  preInstall = ''
    mkdir -p "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
  '';

  meta = {
    description = "A kernel module to create V4L2 loopback devices";
    homepage = "https://github.com/aramg/droidcam";
    license = lib.licenses.gpl2;
    maintainers = [ lib.maintainers.makefu ];
    platforms = lib.platforms.linux;
  };
}
