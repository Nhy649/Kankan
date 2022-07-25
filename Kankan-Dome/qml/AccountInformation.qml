import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Rectangle {
    anchors.fill: parent
    color: "white"
    property alias imageSource: image.source
    property alias nickname: nicknameText.text
    ColumnLayout {
        id: contentColumn
        width: parent.width
        height: parent.height
        spacing: 12
        RowLayout {
            id: titleRow
            height: 40
            spacing: 15
            Button {
                id: to_leftButton
                icon.source: "qrc:to_left.png"
                icon.width: 35
                icon.height: 30
                Layout.alignment: Qt.AlignBottom
                background: Rectangle {
                    color: "white"
                }
                onClicked: {
                    accountInfor.visible = false
                }
            }
            Text {
                text: qsTr("帐号资料")
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
            }
        }
        Rectangle {
            color: "#f2f2f2"
            Layout.fillHeight: true
            Layout.fillWidth: true
            ColumnLayout {
                width: parent.width
                anchors.top: parent.top
                anchors.topMargin: 15
                spacing: 0
                Button {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 70
                    RowLayout {
                        width: parent.width-30
                        height: parent.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text {
                            text: qsTr("头像")
                            font.pixelSize: 14
                            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                        }
                        RowLayout {
                            Layout.alignment: Qt.AlignRight
                            spacing: 10
                            Rectangle {
                                id: headPortrait
                                Layout.preferredHeight: 60
                                Layout.preferredWidth: 60
                                Layout.alignment: Qt.AlignVCenter
                                radius: width/2
                                Image {
                                    id: image
                                    smooth: true
                                    visible: false
                                    anchors.fill: parent
                                    source: "qrc:head_portrait.png"
                                    antialiasing: true
                                }
                                Rectangle {
                                    id: mask
                                    anchors.fill: parent
                                    radius: width/2
                                    visible: false
                                    antialiasing: true
                                    smooth: true
                                }
                                OpacityMask {
                                    id:mask_image
                                    anchors.fill: image
                                    source: image
                                    maskSource: mask
                                    visible: true
                                    antialiasing: true
                                }
                            }
                            Image {
                                source: "qrc:right.png"
                                sourceSize: Qt.size(28, 28)
                                Layout.alignment: Qt.AlignVCenter
                            }
                        }
                    }
                    background: Rectangle {
                        color: "white"
                    }
                    onClicked: {
                        dialogs.fileImageDialog.open()
                    }
                }
                ToolSeparator {
                    Layout.preferredHeight: 1
                    Layout.preferredWidth: parent.width-15
                    Layout.alignment: Qt.AlignRight
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                Button {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 50
                    focus: true
                    RowLayout {
                        width: parent.width-30
                        height: parent.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text {
                            text: qsTr("昵称")
                            font.pixelSize: 14
                            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                        }
                        RowLayout {
                            Layout.alignment: Qt.AlignRight
                            spacing: 10
                            Text {
                                id: nicknameText
                                text: qsTr("汽泡水")
                                font.pixelSize: 14
                                Layout.alignment: Qt.AlignVCenter
                            }
                            Image {
                                source: "qrc:right.png"
                                sourceSize: Qt.size(28, 28)
                                Layout.alignment: Qt.AlignVCenter
                            }
                        }
                    }
                    background: Rectangle {
                        color: "white"
                    }
                    onClicked: {
                        changeNickname.visible = true
                    }
                }
            }
        }
    }
}
