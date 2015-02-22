TARGET = eglfs_rpi

PLUGIN_TYPE = platforms
PLUGIN_CLASS_NAME = QEglFSRPiIntegrationPlugin
!equals(TARGET, $$QT_DEFAULT_QPA_PLUGIN): PLUGIN_EXTENDS = -
load(qt_plugin)

SOURCES += $$PWD/main.cpp

include(eglfs_rpi.pri)
