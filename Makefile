PORTNAME=	xemu
DISTVERSIONPREFIX=	v
DISTVERSION=	0.8.97
CATEGORIES=	emulators

MAINTAINER=	kreinholz@gmail.com
COMMENT=	A free and open-source application that emulates the original \
		Microsoft Xbox game console, enabling people to play their \
		original Xbox games on Windows, macOS, and Linux systems
WWW=		https://xemu.app/

LICENSE=	GPLv2
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	gdb>0:devel/gdb \
		cdrkit-genisoimage>0:sysutils/genisoimage \
		cdrtools>0:sysutils/cdrtools \
		bash>0:shells/bash \
		cmake-core>0:devel/cmake-core \
		meson>0:devel/meson \
		ninja>0:devel/ninja \
		bison>0:devel/bison \
		ccache>0:devel/ccache \
		cmocka>0:sysutils/cmocka \
		cyrus-sasl>0:security/cyrus-sasl2 \
		diffutils>0:textproc/diffutils \
		gsed>0:textproc/gsed \
		gtk-vnc>0:net/gtk-vnc \
		json-c>0:devel/json-c \
		libjpeg-turbo>0:graphics/libjpeg-turbo \
		libtasn1>0:security/libtasn1 \
		mtools>0:filesystems/mtools \
		opencv>0:graphics/opencv \
		py311-numpy>0:math/py-numpy \
		py311-pillow>0:graphics/py-pillow \
		py311-pip>0:devel/py-pip \
		py311-pyyaml>0:devel/py-pyyaml \
		py311-sphinx>0:textproc/py-sphinx \
		py311-sphinx_rtd_theme>0:textproc/py-sphinx_rtd_theme \
		py311-tomli>0:textproc/py-tomli \
		rpm2cpio>0:archivers/rpm2cpio \
		socat>0:net/socat \
		spice-protocol>0:devel/spice-protocol \
		tesseract>0:graphics/tesseract \
		virglrenderer>0:x11/virglrenderer \
		xorriso>0:sysutils/xorriso \
		nlohmann-json>0:devel/nlohmann-json

LIB_DEPENDS=	libdbus-1.so:devel/dbus \
		libepoxy.so:graphics/libepoxy \
		libffi.so:devel/libffi \
		libslirp.so:net/libslirp \
		libpcap.so.1:net/libpcap \
		libcurl.so:ftp/curl \
		libpixman-1.so:x11/pixman \
		libpng.so:graphics/png \
		libsamplerate.so:audio/libsamplerate \
		libspice-server.so:devel/libspice-server \
		libxxhash.so.0:devel/xxhash

USES=		gl gmake gnome pkgconfig python:build sdl shebangfix
USE_GL=		gl
USE_GNOME=	gtk30 glib20
USE_SDL=	sdl2 image2
SHEBANG_GLOB=	*.sh

USE_GITHUB=	yes
GH_ACCOUNT=	xemu-project
GH_TUPLE=	openssl:openssl:openssl-3.0.9:openssl/roms/edk2/CryptoPkg/Library/OpensslLib/openssl \
        	ucb-bar:berkeley-softfloat-3:b64af41c3276f97f0e181920400ee056b9c88037:berkeleysoftfloat3/roms/edk2/ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3 \
        	tianocore:edk2-cmocka:cmocka-1.1.5-23-g1cc9cde:edk2cmocka/roms/edk2/UnitTestFrameworkPkg/Library/CmockaLib/cmocka \
        	kkos:oniguruma:v6.9.4_mark1:oniguruma/roms/edk2/MdeModulePkg/Universal/RegularExpressionDxe/oniguruma \
        	google:brotli:f4153a09f87cbb9c826d8fc12c74642bb2d879ea:brotli/roms/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli \
        	google:brotli:f4153a09f87cbb9c826d8fc12c74642bb2d879ea:brotli/roms/edk2/BaseTools/Source/C/BrotliCompress/brotli \
        	akheron:jansson:v2.13.1:jansson/roms/edk2/RedfishPkg/Library/JsonLib/jansson \
        	google:googletest:release-1.8.0-2983-g86add134:googletest/roms/edk2/UnitTestFrameworkPkg/Library/GoogleTestLib/googletest \
        	tianocore:edk2-subhook:83d4e1ebef3588fae48b69a7352cc21801cb70bc:edk2subhook/roms/edk2/UnitTestFrameworkPkg/Library/SubhookLib/subhook \
        	devicetree-org:pylibfdt:cfff805481bdea27f900c32698171286542b8d3c:pylibfdt/roms/edk2/MdePkg/Library/BaseFdtLib/libfdt \
        	MIPI-Alliance:public-mipi-sys-t:370b5944c046bab043dd8b133727b2135af7747a:publicmipisyst/roms/edk2/MdePkg/Library/MipiSysTLib/mipisyst \
        	ARMmbed:mbedtls:v3.3.0:mbedtls/roms/edk2/CryptoPkg/Library/MbedTlsLib/mbedtls \
        	DMTF:libspdm:50924a4c8145fc721e17208f55814d2b38766fe6:libspdm/roms/edk2/SecurityPkg/DeviceSecurity/SpdmLib/libspdm \
        	pyca:cryptography:38.0.4:cryptography/roms/edk2/CryptoPkg/Library/OpensslLib/openssl/pyca-cryptography \
        	krb5:krb5:aa9b4a2a64046afd2fab7cb49c346295874a5fb6:krb5/roms/edk2/CryptoPkg/Library/OpensslLib/openssl/krb5 \
        	gost-engine:engine:b2b4d629f100eaee9f5942a106b1ccefe85b8808:engine/roms/edk2/CryptoPkg/Library/OpensslLib/openssl/gost-engine \
       		google:wycheproof:2196000605e45d91097147c9c71f26b72af58003:wycheproof/roms/edk2/CryptoPkg/Library/OpensslLib/openssl/wycheproof \
        	provider-corner:libprov:8a126e09547630ef900177625626b6156052f0ee:libprov/roms/edk2/CryptoPkg/Library/OpensslLib/openssl/gost-engine/libprov \
		mborgerson:genconfig:42f85f9a2457e61d7e32542c07723565a284fcd6:genconfig/subprojects/genconfig \
		xemu-project:imgui:7219d617a32b594f9a80b2356aec42e0e939e938:imgui/subprojects/imgui \
		xemu-project:implot:8553562dbb2025fd520f4bed57b094767b96c670:implot/subprojects/implot \
		qemu:keycodemapdb:f5772a62ec52591ff6870b7e8ef32482371f22c6:keycodemapdb/subprojects/keycodemapdb \
		xemu-project:nv2a_vsh_cpu:561fe80da57a881f89000256b459440c0178a7ce:nv2avshcpu/subprojects/nv2a_vsh_cpu \
		marzer:tomlplusplus:30172438cee64926dc41fdd9c11fb3ba5b2ba9de:tomlplusplus/subprojects/tomlplusplus

USE_GITLAB=	nodefault
GL_TUPLE=	qemu-project:berkeley-softfloat-3:b64af41c3276f97f0e181920400ee056b9c88037:berkeleysoftfloat3/subprojects/berkeley-softfloat-3 \
		qemu-project:berkeley-testfloat-3:e7af9751d9f9fd3b47911f51a5cfd08af256a9ab:berkeleytestfloat3/subprojects/berkeley-testfloat-3

LDFLAGS+=	-Wl,--as-needed

MESON_ARGS+=	--wrap-mode=nodownload

PLIST_FILES=	bin/xemu

XEMU_VERSION=	0.8.97
XEMU_COMMIT=	22ea58291dab392a2316f1cf4ced3f52e05142f9

post-extract:
	@${CP} ${WRKSRC}/subprojects/packagefiles/berkeley-softfloat-3/* ${WRKSRC}/subprojects/berkeley-softfloat-3/
	@${CP} ${WRKSRC}/subprojects/packagefiles/berkeley-testfloat-3/* ${WRKSRC}/subprojects/berkeley-testfloat-3/

post-patch:
	@${FIND} ${WRKSRC} -type f -name "*.py" | \
		${XARGS} ${REINPLACE_CMD} -e 's|python3|python${PYTHON_VER}|g'
	@${FIND} ${WRKSRC} -type f -name "*.sh" | \
		${XARGS} ${REINPLACE_CMD} -e 's|python3|python${PYTHON_VER}|g'
	@${REINPLACE_CMD} -e 's|%%XEMU_VERSION%%|${XEMU_VERSION}|' \
		${WRKSRC}/XEMU_VERSION
	@${REINPLACE_CMD} -e 's|%%XEMU_COMMIT%%|${XEMU_COMMIT}|' \
		${WRKSRC}/XEMU_COMMIT

do-build:
	cd ${WRKSRC} && ./build.sh --disable-download --enable-pixman --enable-png --enable-spice --enable-spice-protocol --enable-virglrenderer --enable-sdl-image

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/dist/xemu ${STAGEDIR}${PREFIX}/bin/xemu

.include <bsd.port.mk>
