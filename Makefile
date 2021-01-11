TARGET = iphone:clang
ARCHS = arm64 arm64e
DEBUG = 0
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WinterModeBDD WinterModeBridge

WinterModeBDD_FILES = TweakBDD.xm

WinterModeBridge_FILES = TweakBridge.xm
WinterModeBridge_LDFLAGS += -F./
WinterModeBridge_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

export TWEAK_DISPLAY_NAME = "Winter Mode"
SUBPROJECTS = Settings-Stub

include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 bulletindistributord Bridge Preferences"