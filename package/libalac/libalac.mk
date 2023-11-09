################################################################################
#
# libalac
#
################################################################################

LIBALAC_VERSION = 96dd59d17b776a7dc94ed9b2c2b4a37177feb3c4
LIBALAC_SITE = https://github.com/mikebrady/alac.git
LIBALAC_SITE_METHOD = git

LIBALAC_LICENSE = GPL-2.0
LIBALAC_LICENSE_FILES = COPYING
LIBALAC_CPE_ID_VENDOR = mikebrady
# github tarball does not include configure
LIBALAC_AUTORECONF = YES

LIBALAC_INSTALL_STAGING = YES

define LIBALAC_TARGET_REMOVE_HEADER
        rm -Rf $(TARGET_DIR)/usr/include
endef
LIBALAC_POST_INSTALL_TARGET_HOOKS += LIBALAC_TARGET_REMOVE_HEADER

$(eval $(autotools-package))
