TEMPLATE = lib
TARGET = PlatformPlugin

QT += qml
QT += quick
QT += sql
QT += core
# Needed for iOS / Android integration
QT += gui-private

CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = st.app.platform
QMAKE_MOC_OPTIONS += -Muri=$$uri
RESOURCES += $$_PRO_FILE_PWD_/$${TARGET}.qrc

ios {
    CONFIG += static
    LIBS += -framework MediaPlayer
    LIBS += -framework UIKit
    LIBS += -framework MobileCoreServices
    LIBS += -framework AudioToolbox
    LIBS += -framework iAd
    LIBS += -framework MessageUI

    HEADERS += platformios.h
    OBJECTIVE_SOURCES += \
        platformios.mm \
        imagepicker.mm \
        ad.mm \
        mailer.mm
}

# Input
SOURCES += \
    platform_plugin.cpp

HEADERS += \
    platform_plugin.h \
    definition.h \
    imagepicker.h \
    ad.h \
    mailer.h

OTHER_FILES = qmldir
DISTFILES = qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}
