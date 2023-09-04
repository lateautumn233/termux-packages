TERMUX_PKG_HOMEPAGE=https://linuxcontainers.org/
TERMUX_PKG_DESCRIPTION="Linux Containers"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1:5.0.3
TERMUX_PKG_REVISION=3
TERMUX_PKG_SRCURL=https://linuxcontainers.org/downloads/lxc/lxc-${TERMUX_PKG_VERSION:2}.tar.gz
TERMUX_PKG_SHA256=2693a4c654dcfdafb3aa95c262051d8122afa1b6f5cef1920221ebbdee934d07
TERMUX_PKG_DEPENDS="gnupg, libcap, libcap-static, libseccomp, rsync, wget"
TERMUX_PKG_BREAKS="lxc-dev"
TERMUX_PKG_REPLACES="lxc-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dinit-script=sysvinit
-Druntime-path=/data/local/tmp
--localstatedir=$PREFIX/var/
-Dman=false
"
termux_step_pre_configure() {
	LDFLAGS+=" -Wl,--allow-multiple-definition"
}

termux_step_post_make_install() {
	# Simple helper script for mounting cgroups.
	install -Dm755 "$TERMUX_PKG_BUILDER_DIR"/lxc-setup-cgroups.sh \
		"$TERMUX_PREFIX"/bin/lxc-setup-cgroups
	sed -i "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|" "$TERMUX_PREFIX"/bin/lxc-setup-cgroups
}
