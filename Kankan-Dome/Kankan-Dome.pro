QT += quick

SOURCES += \
        main.cpp

resources.files = qml/main.qml\
    qml/HomePage.qml\
    qml/PersonalPage.qml\
    qml/PublishPage.qml\
    qml/TimeDialog.qml\
    qml/MyFriend.qml

resources.prefix = /$${TARGET}
RESOURCES += resources \
    image/image.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    qml/HomePage.qml \
    qml/ManuscriptPage.qml \
    qml/MyFriend.qml \
    qml/PersonalPage.qml \
    qml/PublishPage.qml \
    qml/TimeDialog.qml
