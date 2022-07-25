import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    anchors.fill: parent
    color: "white"
    Rectangle {
        width: parent.width
        height: 50
        Button {
            id: to_leftButton
            icon.source: "qrc:to_left.png"
            icon.width: 35
            icon.height: 30
            anchors.verticalCenter: parent.verticalCenter
            background: Rectangle {
                color: "white"
            }
            onClicked: {
                changePassword.visible = false
            }
        }
        Text {
            text: qsTr("修改密码")
            font.pixelSize: 16
            anchors.left: to_leftButton.right
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    ColumnLayout {
        id: passwordColumn
        width: parent.width/3*2
        anchors.centerIn: parent
        spacing: 20
        Rectangle {
            Layout.preferredHeight: 40
            Layout.preferredWidth: parent.width
            radius: 50
            border.width: 1
            border.color: "#707070"
            RowLayout {
                width: parent.width-30
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 6
                Text {
                    id: accountText
                    text: qsTr("旧密码:")
                    font.pixelSize: 16
                }
                TextField {
                    id: accountEditText
                    Layout.preferredHeight: parent.height-10
                    Layout.preferredWidth: parent.width-accountText.width-accountBut.width-12
                    background: Rectangle{
                        color: "white"
                    }
                }
                Button {
                    id: accountBut
                    visible: accountEditText.length === 0 ? false : true
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    icon.source: "qrc:clear.png"
                    icon.height: 22
                    icon.width: 22
                    background: Rectangle {
                        color: "white"
                    }
                    onClicked: {
                        accountEditText.clear()
                    }
                }
            }
        }
        Rectangle {
            Layout.preferredHeight: 40
            Layout.preferredWidth: parent.width
            radius: 50
            border.width: 1
            border.color: "#707070"
            RowLayout {
                width: parent.width-30
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 6
                Text {
                    id: passwordText
                    text: qsTr("新密码:")
                    font.pixelSize: 16
                }
                TextField {
                    id: passwordEditText
                    Layout.preferredHeight: parent.height-10
                    Layout.preferredWidth: parent.width-passwordText.width-passwordBut.width-12

                    background: Rectangle{
                        color: "white"
                    }
                    echoMode: TextInput.Password
                }
                Button {
                    id: passwordBut
                    visible: passwordEditText.length === 0 ? false : true
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    background: Rectangle {
                        color: "white"
                    }
                    Button {
                        id: passwordButHit
                        anchors.fill: parent
                        visible: true
                        icon.source: "qrc:eye_hide.png"
                        icon.height: 22
                        icon.width: 22
                        background: Rectangle {
                            color: "white"
                        }
                        onClicked: {
                            passwordButHit.visible = false
                            passwordButVis.visible = true
                            passwordEditText.echoMode = TextInput.Normal
                        }
                    }
                    Button {
                        id: passwordButVis
                        visible: false
                        anchors.fill: parent
                        icon.source: "qrc:eye_visible.png"
                        icon.height: 22
                        icon.width: 22
                        background: Rectangle {
                            color: "white"
                        }
                        onClicked: {
                            passwordButVis.visible = false
                            passwordButHit.visible = true
                            passwordEditText.echoMode = TextInput.Password
                        }
                    }
                }
            }
        }
        Rectangle {
            Layout.preferredHeight: 40
            Layout.preferredWidth: parent.width
            radius: 50
            border.width: 1
            border.color: "#707070"
            RowLayout {
                width: parent.width-30
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 6
                Text {
                    id: confirmPasswordText
                    text: qsTr("确认密码:")
                    font.pixelSize: 16
                }
                TextField {
                    id: confirmPasswordEditText
                    Layout.preferredHeight: parent.height-10
                    Layout.preferredWidth: parent.width-confirmPasswordText.width-confirmPasswordBut.width-12

                    background: Rectangle{
                        color: "white"
                    }
                    echoMode: TextInput.Password
                }
                Button {
                    id: confirmPasswordBut
                    visible: passwordEditText.length === 0 ? false : true
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    background: Rectangle {
                        color: "white"
                    }
                    Button {
                        id: confirmPasswordButHit
                        anchors.fill: parent
                        visible: true
                        icon.source: "qrc:eye_hide.png"
                        icon.height: 22
                        icon.width: 22
                        background: Rectangle {
                            color: "white"
                        }
                        onClicked: {
                            confirmPasswordButHit.visible = false
                            confirmPasswordButVis.visible = true
                            confirmPasswordEditText.echoMode = TextInput.Normal
                        }
                    }
                    Button {
                        id: confirmPasswordButVis
                        visible: false
                        anchors.fill: parent
                        icon.source: "qrc:eye_visible.png"
                        icon.height: 22
                        icon.width: 22
                        background: Rectangle {
                            color: "white"
                        }
                        onClicked: {
                            confirmPasswordButVis.visible = false
                            confirmPasswordButHit.visible = true
                            confirmPasswordEditText.echoMode = TextInput.Password
                        }
                    }
                }
            }
        }
        Button {
            id: registerButton
            Layout.preferredWidth: 100
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 80
            Text {
                text: qsTr("保存")
                color: "white"
                anchors.centerIn: parent
            }
            background: Rectangle {
                color: "#24c3f5"
                radius: 10
            }
            onClicked: {
                //先判断旧密码是否正确

                if (passwordEditText.text === confirmPasswordEditText.text) {
                    //两次输入相同
                    mainPage.visible = true
                    registerPage.visible = false
                } else {
                    errorText.visible = true
                    passwordTimer.running = true
                }
            }
        }
    }
    Text {
        id: errorText
        visible: false
        text: qsTr("密码不匹配！")
        color: "red"
        font.pixelSize: 14
        anchors.centerIn: parent
    }
    Timer {
        id: passwordTimer
        interval: 3000
        running: false
        repeat: false
        onTriggered: {
            errorText.visible = false
        }
    }
}
