QT += quick

SOURCES += \
        main.cpp

resources.files = qml/main.qml\
    qml/MainPage.qml\
    qml/HomePage.qml\
    qml/PersonalPage.qml\
    qml/PublishPage.qml\
    qml/TimeDialog.qml\
    qml/MyFriend.qml\
    qml/ManuscriptPage.qml\
    qml/EditManuscript.qml\
    qml/CommentManger.qml\
    qml/SettingPage.qml\
    qml/AccountInformation.qml\
    qml/LoginPage.qml\
    qml/RegisterPage.qml\
    qml/WatchVideo.qml\
    qml/FullScreen.qml\
    qml/QmlBusyIndicator.qml\
    qml/ChangePassword.qml\
    qml/ChangeNickname.qml\
    qml/Dialogs.qml

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
    qml/AccountInformation.qml \
    qml/ChangeNickname.qml \
    qml/ChangePassword.qml \
    qml/CommentManger.qml \
    qml/Dialogs.qml \
    qml/EditManuscript.qml \
    qml/FullScreen.qml \
    qml/HomePage.qml \
    qml/LoginPage.qml \
    qml/MainPage.qml \
    qml/ManuscriptPage.qml \
    qml/MyFriend.qml \
    qml/PersonalPage.qml \
    qml/PublishPage.qml \
    qml/QmlBusyIndicator.qml \
    qml/RegisterPage.qml \
    qml/SettingPage.qml \
    qml/TimeDialog.qml \
    qml/WatchVideo.qml
