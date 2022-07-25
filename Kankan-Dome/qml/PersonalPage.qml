import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Rectangle {
    id: personal
    width: parent.width
    height: parent.height
    RowLayout {
        id: personalMessage
        height: 60
        spacing: 20
        Rectangle {
            id: img
            Layout.preferredHeight: 50
            Layout.preferredWidth: 50
            Layout.leftMargin: 10
            radius: width/2
            Image {
                id: image
                smooth: true
                visible: false
                anchors.fill: parent
                source: "qrc:head_portrait.png"
                sourceSize: Qt.size(70, 70)
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
        Text {
            id: nickname
            text: qsTr("text")
            font.pointSize: 16
        }
    }
    ToolBar {
        id: toolBar
        width: parent.width
        height: 60
        anchors.top: personalMessage.bottom
        background: Rectangle {
            color: "white"
        }

        RowLayout {
            width: parent.width
            height: parent.height
            spacing: 0
            ToolButton {
                id: manuscript
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: (parent.width-6)/3
                background: Rectangle {
                    color: "white"
                }

                ColumnLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text {
                        id: manuscriptText
                        text: qsTr("稿件")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 12
                        color: "#707070"
                    }
                    Text {
                        id: manuscriptNumText
                        text: qsTr("1")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 10
                        color: "#707070"
                    }
                }
                onClicked: {
                    mainPage.visible = false
                    manuscriptPage.visible = true
                }
            }
            ToolSeparator {
                Layout.preferredHeight: toolBar.height-32
                Layout.preferredWidth: 3
                contentItem: Rectangle{
                    anchors.fill: parent
                    color: "#88def9"
                }
            }
            ToolButton {
                id: fanButton
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: (parent.width-6)/3
                background: Rectangle {
                    color: "white"
                }
                ColumnLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text {
                        id: fansText
                        text: qsTr("粉丝")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 12
                        color: "#707070"
                    }
                    Text {
                        id: fansNumText
                        text: qsTr("2")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 10
                        color: "#707070"
                    }
                }
                onClicked: {
                    mainPage.visible = false
                    myFriend.friendBar.currentIndex = 1
                    myFriend.visible = true
                }
            }
            ToolSeparator {
                Layout.preferredHeight: toolBar.height-32
                Layout.preferredWidth: 3
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: "#88def9"
                }
            }
            ToolButton {
                id: followerButton
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: (parent.width-6)/3
                background: Rectangle {
                    color: "white"
                }
                ColumnLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text {
                        id: followerText
                        text: qsTr("关注")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 12
                        color: "#707070"
                    }
                    Text {
                        id: followerNumText
                        text: qsTr("10")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 10
                        color: "#707070"
                    }
                }
                onClicked: {
                    mainPage.visible = false
                    myFriend.friendBar.currentIndex = 0
                    myFriend.visible = true
                }
            }
        }
    }
    ToolSeparator {
        id: toolS
        height: 2
        width: parent.width
        anchors.top: toolBar.bottom
        contentItem: Rectangle{
            anchors.fill: parent
            color: "#cccccc"
        }
    }
    Rectangle {
        id: contentRec
        width: parent.width-20
        height: parent.height-personalMessage.height-toolBar.height-toolS.height-10
        anchors.top: toolS.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        ScrollView {
            anchors.fill: parent
            clip: true
            ScrollBar.horizontal: ScrollBar{ visible: true }
            ColumnLayout {
                width: contentRec.width
                spacing: 10
                RowLayout {
                    Layout.preferredWidth: parent.width
                    spacing: 0
                    Button {
                        Layout.preferredHeight: 60
                        Layout.preferredWidth: parent.width/4
                        background: Rectangle {
                            color: "white"
                        }
                        ColumnLayout {
                            spacing: 5
                            anchors.centerIn: parent
                            Image {
                                source: "qrc:download.png"
                                sourceSize: Qt.size(25, 25)
                                Layout.alignment: Qt.AlignHCenter
                            }
                            Text {
                                text: qsTr("离线缓存")
                            }
                        }
                    }
                    Button {
                        Layout.preferredHeight: 60
                        Layout.preferredWidth: parent.width/4
                        background: Rectangle {
                            color: "white"
                        }
                        ColumnLayout {
                            spacing: 5
                            anchors.centerIn: parent
                            Image {
                                source: "qrc:history.png"
                                sourceSize: Qt.size(26, 26)
                                Layout.alignment: Qt.AlignHCenter
                            }
                            Text {
                                text: qsTr("历史记录")
                            }
                        }
                    }
                    Button {
                        Layout.preferredHeight: 60
                        Layout.preferredWidth: parent.width/4
                        background: Rectangle {
                            color: "white"
                        }
                        ColumnLayout {
                            spacing: 5
                            anchors.centerIn: parent
                            Image {
                                source: "qrc:myCollect.png"
                                sourceSize: Qt.size(28, 28)
                                Layout.alignment: Qt.AlignHCenter
                            }
                            Text {
                                text: qsTr("我的收藏")
                            }
                        }
                    }
                    Button {
                        Layout.preferredHeight: 60
                        Layout.preferredWidth: parent.width/4
                        background: Rectangle {
                            color: "white"
                        }
                        ColumnLayout {
                            spacing: 5
                            anchors.centerIn: parent
                            Image {
                                source: "qrc:watchLater.png"
                                sourceSize: Qt.size(28, 28)
                                Layout.alignment: Qt.AlignHCenter
                            }
                            Text {
                                text: qsTr("稍后再看")
                            }
                        }
                    }
                }
                ColumnLayout {
                    Layout.preferredWidth: parent.width
                    spacing: 10
                    Text {
                        text: qsTr("推荐服务")
                    }
                    GridView {
                        id: iconView
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 210
                        cellHeight: 70
                        cellWidth: width/4
                        model: iconModel
                        delegate: iconDelegate
                    }
                }
                ColumnLayout{
                    spacing: 5
                    Layout.preferredWidth: parent.width
                    Text {
                        text: qsTr("更多服务")
                    }
                    Rectangle {
                        Layout.preferredWidth: parent.width-20
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignHCenter
                        Image {
                            id: setImage
                            source: "qrc:set.png"
                            sourceSize: Qt.size(30, 30)
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: qsTr("设置")
                            font.pixelSize: 14
                            anchors.left: setImage.right
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Image {
                            source: "qrc:right.png"
                            sourceSize: Qt.size(30, 30)
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        TapHandler {
                            onTapped: {
                                settingPage.visible = true
                                mainPage.visible = false
                            }
                        }
                    }
                    Rectangle {
                        Layout.preferredWidth: parent.width-20
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignHCenter
                        Image {
                            id: serviceImage
                            source: "qrc:service.png"
                            sourceSize: Qt.size(28, 28)
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: qsTr("联系客服")
                            font.pixelSize: 14
                            anchors.left: serviceImage.right
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Image {
                            source: "qrc:right.png"
                            sourceSize: Qt.size(30, 30)
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Rectangle {
                        Layout.preferredWidth: parent.width-20
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignHCenter
                        Image {
                            id: adolescentModelImage
                            source: "qrc:bud.png"
                            sourceSize: Qt.size(28, 28)
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: qsTr("青少年守护")
                            font.pixelSize: 14
                            anchors.left: adolescentModelImage.right
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Image {
                            source: "qrc:right.png"
                            sourceSize: Qt.size(30, 30)
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
    ListModel {
        id: iconModel
        ListElement { iconSource: "qrc:myCourses.png"; iconText: qsTr("我的课程") }
        ListElement { iconSource: "qrc:freeTraffic.png"; iconText: qsTr("免流量服务") }
        ListElement { iconSource: "qrc:skin.png"; iconText: qsTr("个性装扮") }
        ListElement { iconSource: "qrc:wallet.png"; iconText: qsTr("我的钱包") }
        ListElement { iconSource: "qrc:game.png"; iconText: qsTr("游戏中心") }
        ListElement { iconSource: "qrc:shopping.png"; iconText: qsTr("会员购中心") }
        ListElement { iconSource: "qrc:live.png"; iconText: qsTr("直播中心") }
        ListElement { iconSource: "qrc:recommend.png"; iconText: qsTr("推荐有奖") }
        ListElement { iconSource: "qrc:community.png"; iconText: qsTr("社区中心") }
        ListElement { iconSource: "qrc:publicBenefit.png"; iconText: qsTr("公益中心") }
        ListElement { iconSource: "qrc:welfare.png"; iconText: qsTr("充能领福利") }
        ListElement { iconSource: "qrc:cheerUp.png"; iconText: qsTr("能量加油站") }
    }
    Component {
        id: iconDelegate
        Button {
            height: 70
            width: iconView.width/4
            background: Rectangle {
                color: "white"
            }
            ColumnLayout {
                spacing: 5
                anchors.centerIn: parent
                Image {
                    source: iconSource
                    sourceSize: Qt.size(30, 30)
                    Layout.alignment: Qt.AlignHCenter
                }
                Text {
                    text: iconText
                    font.pixelSize: 14
                }
            }
        }
    }
}
