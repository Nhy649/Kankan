import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: main
    width: 400
    height: 700
    visible: true
    color: "white"
    LoginPage {
        id: loginPage
        anchors.fill: parent
        visible: true
    }
    RegisterPage {
        id: registerPage
        anchors.fill: parent
        visible: false
    }

    MainPage {
        id: mainPage
        anchors.fill: parent
        visible: false
    }
    PublishPage {
        id: publishPage
        visible: false
        anchors.fill: parent
    }
    SettingPage {
        id: settingPage
        visible: false
        anchors.fill: parent
    }
    AccountInformation {
        id: accountInfor
        visible: false
        anchors.fill: parent
    }
    ChangePassword {
        id: changePassword
        visible: false
        anchors.fill: parent
    }
    ChangeNickname{
        id: changeNickname
        visible: false
        anchors.fill: parent
    }

    MyFriend {
        id: myFriend
        anchors.fill: parent
        visible: false
    }
    ManuscriptPage {
        id: manuscriptPage
        anchors.fill: parent
        visible: false
    }
    CommentManger {
        id: commentManger
        anchors.fill: parent
        visible: false
    }
    StackView {
        id: stackView
        anchors.fill: parent
        visible: false
    }
    Component {
        id: watchVideo
        WatchVideo {
            width: stackView.width
            height: stackView.height
        }
    }
    Dialogs {
        id: dialogs
    }
}
