################################################################################
#
# lvgl
#
################################################################################

LVGL_VERSION = adf2c4490e17a1b9ec1902cc412a24b3b8235c8e
LVGL_SITE = https://github.com/lvgl/lv_port_linux_frame_buffer.git
LVGL_SITE_METHOD = git
LVGL_GIT_SUBMODULES = YES

LVGL_LICENSE = MIT
LVGL_LICENSE_FILES = LICENSE

LVGL_DEPENDENCIES = host-cmake wayland wayland-protocols

LVGL_CONF_OPTS = -DBUILD_SHARED_LIBS=OFF

define LVGL_GENERATE_WAYLAND_PROTOCOLS_CLIENT_FILES
	mkdir -p $(@D)/lv_drivers/wayland/protocols && \
	\
	$(HOST_DIR)/bin/wayland-scanner private-code \
	$(HOST_DIR)/aarch64-nuvoton-linux-gnu/sysroot/usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml \
	$(@D)/lv_drivers/wayland/protocols/xdg-shell-protocol.c && \
	\
	$(HOST_DIR)/bin/wayland-scanner client-header \
	$(HOST_DIR)/aarch64-nuvoton-linux-gnu/sysroot/usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml \
	$(@D)/lv_drivers/wayland/protocols/xdg-shell-client-protocol.h
endef
LVGL_PRE_CONFIGURE_HOOKS += LVGL_GENERATE_WAYLAND_PROTOCOLS_CLIENT_FILES

$(eval $(cmake-package))
