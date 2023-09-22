################################################################################
#
# NQPTP
#
################################################################################

NQPTP_VERSION = 1.2.4
NQPTP_SITE = $(call github,mikebrady,nqptp,$(NQPTP_VERSION))
NQPTP_LICENSE = GPL-2.0
NQPTP_LICENSE_FILES = COPYING
NQPTP_CPE_ID_VENDOR = mikebrady
# github tarball does not include configure
NQPTP_AUTORECONF = YES

ifeq ($(BR2_INIT_SYSTEMD),y)
NQPTP_CONF_OPTS += --with-systemd-startup
endif

define NQPTP_INSTALL_INIT_SYSV
        $(INSTALL) -D -m 0755 package/nqptp/S60nqptp \
                $(TARGET_DIR)/etc/init.d/S60nqptp
endef

$(eval $(autotools-package))
