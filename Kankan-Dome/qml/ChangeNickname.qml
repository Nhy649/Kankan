import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    anchors.fill: parent
    color: "white"
    Column {
        id: contentColumn
        width: parent.width
        height: parent.height
        spacing: 12
        RowLayout {
            id: titleRow
            width: parent.width
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
                    changeNickname.visible = false
                }
            }
            Text {
                text: qsTr("修改昵称")
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
            }
            Button {
                id: saveButton
                Layout.preferredWidth: 50
                Layout.preferredHeight: 30
                Layout.alignment: Qt.AlignBottom | Qt.AlignRight
                Layout.rightMargin: 10
                Text {
                    text: qsTr("保存")
                    font.pixelSize: 14
                    anchors.centerIn: parent
                }
                background: Rectangle {
                    color: "white"
                }
                onClicked: {
                    accountInfor.nickname = nicknameEdit.text
                    changeNickname.visible = false
                }
            }
        }
        ToolSeparator {
            height: 1
            width: parent.width
            contentItem: Rectangle{
                anchors.fill: parent
                color: "#cccccc"
            }
        }
        ColumnLayout {
            width: parent.width
            spacing: 1
            TextField {
                id: nicknameEdit
                Layout.preferredWidth: parent.width-20
                Layout.preferredHeight: 40
                Layout.alignment: Qt.AlignHCenter
                placeholderText: qsTr("请输入昵称...")
                font.pixelSize: 14
                background: Rectangle {
                    color: "white"
                }
            }
            ToolSeparator {
                Layout.preferredHeight: 1
                Layout.preferredWidth: parent.width-20
                Layout.alignment: Qt.AlignHCenter
                contentItem: Rectangle{
                    anchors.fill: parent
                    color: "#24c3f5"
                }
            }
        }
    }
}
