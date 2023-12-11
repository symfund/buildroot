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

$(eval $(cmake-package))
