TARGET = eglfs_rpi

PLUGIN_TYPE = platforms
PLUGIN_CLASS_NAME = QEglFSIntegrationPlugin

load(qt_plugin)

QT += core-private gui-private platformsupport-private

unix {
    CONFIG += link_pkgconfig
    PKGCONFIG += egl glesv2
}

#DEFINES += QEGL_EXTRA_DEBUG

# Avoid X11 header collision
DEFINES += MESA_EGL_NO_X11_HEADERS

# To test the hooks on x11 (xlib), comment the above define too
EGLFS_PLATFORM_HOOKS_SOURCES += qeglfshooks_pi.cpp
#LIBS += -lbcm_host

SOURCES =   main.cpp \
            qeglfsintegration.cpp \
            qeglfswindow.cpp \
            qeglfsbackingstore.cpp \
            qeglfsscreen.cpp \
            qeglfshooks_stub.cpp \
            qeglfscursor.cpp \
            qeglfscontext.cpp

HEADERS =   qeglfsintegration.h \
            qeglfswindow.h \
            qeglfsbackingstore.h \
            qeglfsscreen.h \
            qeglfscursor.h \
            qeglfshooks.h \
            qeglfscontext.h

QMAKE_LFLAGS += $$QMAKE_LFLAGS_NOUNDEF

INCLUDEPATH += $$PWD /usr/include/interface/vmcs_host/linux

!isEmpty(EGLFS_PLATFORM_HOOKS_SOURCES) {
    HEADERS += $$EGLFS_PLATFORM_HOOKS_HEADERS
    SOURCES += $$EGLFS_PLATFORM_HOOKS_SOURCES
    LIBS    += $$EGLFS_PLATFORM_HOOKS_LIBS
    DEFINES += EGLFS_PLATFORM_HOOKS
}

CONFIG += egl qpa/genericunixfontdatabase
LIBS += -lglib-2.0 -ludev -lmtdev
target.path += $$[QT_INSTALL_PLUGINS]/platforms
INSTALLS += target

RESOURCES += cursor.qrc

OTHER_FILES += \
    eglfs_rpi.json
