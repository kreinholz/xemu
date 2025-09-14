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
GH_TUPLE=	mborgerson:genconfig:42f85f9a2457e61d7e32542c07723565a284fcd6:genconfig/subprojects/genconfig \
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

PLIST_FILES=	bin/xemu \
		share/applications/xemu.desktop \
		share/applications/xemu.metainfo.xml \
		share/icons/hicolor/scalable/apps/xemu.svg \
		share/icons/hicolor/256x256/apps/xemu.png \
		share/icons/hicolor/128x128/apps/xemu.png \
		share/icons/hicolor/64x64/apps/xemu.png \
		share/icons/hicolor/48x48/apps/xemu.png \
		share/icons/hicolor/32x32/apps/xemu.png \
		share/icons/hicolor/24x24/apps/xemu.png

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
	${INSTALL_KLD} ${WRKSRC}/ui/xemu.desktop ${STAGEDIR}${PREFIX}/share/applications
	${INSTALL_KLD} ${WRKSRC}/xemu.metainfo.xml ${STAGEDIR}${PREFIX}/share/applications
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/scalable/apps
	${INSTALL_KLD} ${WRKSRC}/ui/icons/xemu.svg ${STAGEDIR}${PREFIX}/share/icons/hicolor/scalable/apps
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/256x256/apps
	${INSTALL_KLD} ${WRKSRC}/ui/icons/xemu_256x256.png ${STAGEDIR}${PREFIX}/share/icons/hicolor/256x256/apps/xemu.png
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/128x128/apps
	${INSTALL_KLD} ${WRKSRC}/ui/icons/xemu_128x128.png ${STAGEDIR}${PREFIX}/share/icons/hicolor/128x128/apps/xemu.png
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/64x64/apps
	${INSTALL_KLD} ${WRKSRC}/ui/icons/xemu_64x64.png ${STAGEDIR}${PREFIX}/share/icons/hicolor/64x64/apps/xemu.png
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/48x48/apps
	${INSTALL_KLD} ${WRKSRC}/ui/icons/xemu_48x48.png ${STAGEDIR}${PREFIX}/share/icons/hicolor/48x48/apps/xemu.png
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/32x32/apps
	${INSTALL_KLD} ${WRKSRC}/ui/icons/xemu_32x32.png ${STAGEDIR}${PREFIX}/share/icons/hicolor/32x32/apps/xemu.png
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/24x24/apps
	${INSTALL_KLD} ${WRKSRC}/ui/icons/xemu_24x24.png ${STAGEDIR}${PREFIX}/share/icons/hicolor/24x24/apps/xemu.png

.include <bsd.port.mk>
