TARGET = eglfs_rpi

PLUGIN_TYPE = platforms
PLUGIN_CLASS_NAME = QEglFSRPiIntegrationPlugin

load(qt_plugin)

QT += core-private gui-private platformsupport-private

DEFINES += QEGL_EXTRA_DEBUG

# Avoid X11 header collision
DEFINES += MESA_EGL_NO_X11_HEADERS

################
# RaspberryPi
################
EGLFS_PLATFORM_HOOKS_SOURCES += qeglfshooks_pi.cpp
EGLFS_PLATFORM_HOOKS_LIBS = -lbcm_host

QMAKE_VC_DIR = /opt/vc
QMAKE_LIBDIR_VC = $$QMAKE_VC_DIR/lib
QMAKE_INCDIR_VC = $$QMAKE_VC_DIR/include \
                  $$QMAKE_VC_DIR/include/interface/vcos/pthreads \
                  $$QMAKE_VC_DIR/include/interface/vmcs_host/linux

QMAKE_LFLAGS += -Wl,-rpath-link,$$QMAKE_LIBDIR_VC
#QMAKE_LIBS_EGL = -lEGL -lGLESv2
QMAKE_LIBS_EGL = -L$$QMAKE_LIBDIR_VC -lEGL -lGLESv2 -lm -lbcm_host

INCLUDEPATH += $$QMAKE_INCDIR_VC
LIBS += -L$$QMAKE_LIBDIR_VC
################

SOURCES +=  $$PWD/main.cpp \
            $$PWD/qeglfsintegration.cpp \
            $$PWD/qeglfswindow.cpp \
            $$PWD/qeglfsscreen.cpp \
            $$PWD/qeglfshooks_stub.cpp \
            $$PWD/qeglfscontext.cpp

HEADERS +=  $$PWD/qeglfsintegration.h \
            $$PWD/qeglfswindow.h \
            $$PWD/qeglfsscreen.h \
            $$PWD/qeglfshooks.h \
            $$PWD/qeglfscontext.h

QMAKE_LFLAGS += $$QMAKE_LFLAGS_NOUNDEF

!isEmpty(EGLFS_PLATFORM_HOOKS_SOURCES) {
    HEADERS += $$EGLFS_PLATFORM_HOOKS_HEADERS
    SOURCES += $$EGLFS_PLATFORM_HOOKS_SOURCES
    LIBS    += $$EGLFS_PLATFORM_HOOKS_LIBS
    DEFINES += EGLFS_PLATFORM_HOOKS
}

CONFIG += egl qpa/genericunixfontdatabase

RESOURCES += cursor.qrc

OTHER_FILES += \
    eglfs_rpi.json

#contains(QT_CONFIG,glib): LIBS_PRIVATE += $$QT_LIBS_GLIB
#contains(QT_CONFIG,fontconfig): LIBS_PRIVATE += $$QMAKE_LIBS_FONTCONFIG
#contains(QT_CONFIG,libudev): LIBS_PRIVATE += $$QMAKE_LIBS_LIBUDEV
#contains(QT_CONFIG,mtdev): LIBS_PRIVATE += -lmtdev

target.path += $$[QT_INSTALL_PLUGINS]/platforms
INSTALLS += target
