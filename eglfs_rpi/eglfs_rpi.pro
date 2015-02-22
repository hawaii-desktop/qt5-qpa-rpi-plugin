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

# RaspberryPi
EGLFS_PLATFORM_HOOKS_SOURCES += qeglfshooks_pi.cpp
EGLFS_PLATFORM_HOOKS_LIBS = -lbcm_host

QMAKE_LFLAGS           += -Wl,-rpath-link,$$[QT_SYSROOT]/opt/vc/lib

QMAKE_LIBDIR_OPENGL_ES2 = $$[QT_SYSROOT]/opt/vc/lib
QMAKE_LIBDIR_EGL        = $$QMAKE_LIBDIR_OPENGL_ES2

QMAKE_INCDIR_EGL        = $$[QT_SYSROOT]/opt/vc/include \
                          $$[QT_SYSROOT]/opt/vc/include/interface/vcos/pthreads \
                          $$[QT_SYSROOT]/opt/vc/include/interface/vmcs_host/linux
QMAKE_INCDIR_OPENGL_ES2 = $${QMAKE_INCDIR_EGL}

QMAKE_LIBS_EGL          = -lEGL -lGLESv2

contains(DISTRO, squeeze) {
    #Debian Squeeze: Legacy everything
    QMAKE_LIBS_OPENGL_ES2   = -lGLESv2 -lEGL
} else:contains(DISTRO, arch) {
    #On principle: no wizardry required
} else {
    #This is not strictly necessary
    DISTRO_OPTS += deb-multi-arch
    DISTRO_OPTS += hard-float
}

QMAKE_CFLAGS           += \
                          -marm \
                          -mfpu=vfp \
                          -mtune=arm1176jzf-s \
                          -march=armv6zk \
                          -mabi=aapcs-linux

QMAKE_CXXFLAGS          = $$QMAKE_CFLAGS
################

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
