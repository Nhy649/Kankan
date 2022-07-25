import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    id: home
    width: parent.width
    height: parent.height
    property int nPullHeight: 40    //拉动的高度

    //启动下刷新...
    function funDownRefresh(){
        console.log(qsTr("启动下刷新..."))
        console.log(videoListView.contentY)
        busyDownRefresh.visible = true
        timerDownRefresh.start()
    }

    //启动上刷新...
    function funUpRefresh(){
        console.log(qsTr("启动上刷新..."))
        console.log(videoListView.contentHeight)

        busyUpRefresh.visible = true
        timerUpRefresh.start();
    }


    Column {
        anchors.fill: parent
        spacing: 0
        RowLayout {
            id: header
            height: 50
            width: parent.width
            spacing: 10
            Rectangle {
                id: headPortrait
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                Layout.leftMargin: 10
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
            Rectangle {
                id: rectangle
                Layout.preferredHeight: 35
                Layout.preferredWidth: parent.width-headPortrait.width-messageImg.width-40
                radius: 50
                border.width: 1
                border.color: "#707070"
                RowLayout {
                    width: parent.width-20
                    height: parent.height
                    anchors.centerIn: parent
                    spacing: 10
                    Image {
                        id: searchImg
                        Layout.preferredHeight: 20
                        Layout.preferredWidth: 20
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:search.png"
                    }
                    TextField {
                        id: editText
                        Layout.preferredHeight: parent.height-10
                        Layout.preferredWidth: parent.width-searchImg.width-clearButton.width-20
                        background: Rectangle{
                            color: "white"
                        }
                        Shortcut {
                            sequence: "Return"
                            onActivated: {
                                console.log("确认")
                            }
                        }
                    }
                    Button {
                        id: clearButton
                        visible: editText.length === 0 ? false : true
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 30
                        icon.source: "qrc:clear.png"
                        icon.height: 22
                        icon.width: 22
                        background: Rectangle {
                            color: "white"
                        }
                        onClicked: {
                            editText.clear()
                        }
                    }
                }
            }
            Image {
                id: messageImg
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                fillMode: Image.PreserveAspectFit
                source: "qrc:message.png"
                Layout.rightMargin: 12
                TapHandler {
                    onTapped: {
                        commentManger.visible = true
                    }
                }
            }
        }
        Rectangle {
            height: parent.height-header.height
            width: parent.width
            color: "#f2f2f2"
            ScrollView {
                anchors.fill: parent
                clip: true
                ScrollBar.horizontal: ScrollBar{ visible: true }
                ListView {
                    id: videoListView
                    anchors.fill: parent
                    model: videoModel
                    delegate: contactDelegate
                    states: [
                        State {
                            id: downRefresh
                            name: "downRefresh";
                            when: (videoListView.contentHeight > 0) && (videoListView.contentY > (videoListView.contentHeight - videoListView.height + nPullHeight))
                            StateChangeScript {
                                name: "funDownRefresh"
                                script: funDownRefresh()
                            }
                        },
                        State {
                            id: upRefresh
                            name: "upRefresh"; when: (videoListView.contentY < -nPullHeight)
                            StateChangeScript {
                                name: "funUpRefresh"
                                script: funUpRefresh()
                            }
                        }
                    ]
                }
            }
        }
    }
    Component {
        id: contactDelegate
        ColumnLayout {
            width: videoListView.width
            spacing: 0
            Image {
                id: bigVideoCoverI
                Layout.preferredWidth: parent.width-20
                Layout.preferredHeight: parent.width/16*9
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 10
                fillMode: Image.PreserveAspectCrop
                source: bigVideoCover
                RowLayout {
                    width: parent.width-10
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.margins: 5
                    spacing: 8
                    Row {
                        Layout.alignment: Qt.AlignLeft
                        spacing: 1
                        Button {
                            icon.source: "qrc:video_white.png"
                            icon.width: 18
                            icon.height: 18
                            background: Rectangle {
                                opacity: 0
                            }
                        }
                        Text {
                            width: 30
                            text: playNum
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Button {
                            icon.source: "qrc:comment_white.png"
                            icon.width: 16
                            icon.height: 16
                            background: Rectangle {
                                opacity: 0
                            }
                        }
                        Text {
                            text: playNum
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Text {
                        text: duration
                        color: "white"
                        Layout.alignment: Qt.AlignRight
                    }
                }
                TapHandler {
                    onTapped: {
                        stackView.push(watchVideo, {videoSource: bigVideoUrl})
                        mainPage.visible = false
                        stackView.visible = true
                    }
                }
            }
            Rectangle {
                id: titleRec
                color: "white"
                Layout.preferredWidth: parent.width-20
                Layout.preferredHeight: bigVideoTitleT.height+10
                Layout.alignment: Qt.AlignHCenter
                Text {
                    id: bigVideoTitleT
                    width: parent.width-20
                    height: 40
                    anchors.centerIn: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: videoTitle
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                }
            }
            GridView {
                id: videoView
                Layout.preferredWidth: parent.width-10
                Layout.preferredHeight: cellHeight*count/2
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 10
                cellWidth: width/2
                cellHeight: 195
                interactive: false
                model: videoUrls
                delegate: Rectangle {
                    width: videoView.cellWidth
                    height: videoView.cellHeight
                    color: "#f2f2f2"
                    Image {
                        id: videoCoverI
                        source: videoCover
                        width: parent.width-10
                        height: width/16*9
                        anchors.horizontalCenter: parent.horizontalCenter
                        fillMode: Image.PreserveAspectCrop
                        RowLayout {
                            width: parent.width-10
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.margins: 5
                            spacing: 8
                            Row {
                                Layout.alignment: Qt.AlignLeft
                                spacing: 1
                                Button {
                                    icon.source: "qrc:video_white.png"
                                    icon.width: 18
                                    icon.height: 18
                                    background: Rectangle {
                                        opacity: 0
                                    }
                                }
                                Text {
                                    width: 30
                                    text: playNum
                                    color: "white"
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Button {
                                    icon.source: "qrc:comment_white.png"
                                    icon.width: 16
                                    icon.height: 16
                                    background: Rectangle {
                                        opacity: 0
                                    }
                                }
                                Text {
                                    text: commentNum
                                    color: "white"
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                            Text {
                                text: duration
                                color: "white"
                                Layout.alignment: Qt.AlignRight
                            }
                        }
                        TapHandler {
                            onTapped: {
                                stackView.push(watchVideo, {videoSource: videoUrl})
                                mainPage.visible = false
                                stackView.visible = true
                            }
                        }
                    }
                    Rectangle {
                        color: "white"
                        width: parent.width-10
                        height: 80
                        anchors.top: videoCoverI.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text {
                            id: videoTitleT
                            width: parent.width-20
                            height: 40
                            anchors.top: parent.top
                            anchors.topMargin: 5
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: videoTitle
                            wrapMode: Text.WordWrap
                            elide: Text.ElideRight
                        }
                        Rectangle {
                            id: authorLabel
                            width: authorText.width+4
                            height: authorText.height+4
                            anchors.top: videoTitleT.bottom
                            anchors.topMargin: 5
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            border.color: "#cccccc"
                            border.width: 1
                            radius: 3
                            Text {
                                id: authorText
                                text: qsTr("作者")
                                color: "#cccccc"
                                anchors.centerIn: parent
                            }
                        }
                        Text {
                            text: authorName
                            anchors.left: authorLabel.right
                            anchors.leftMargin: 5
                            anchors.top: videoTitleT.bottom
                            anchors.topMargin: 5
                        }
                    }
                }
            }
        }
    }
    ListModel {
        id: videoModel
        Component.onCompleted: {
            append({bigVideoUrl: "file:///root/1.mkv", bigVideoCover: "qrc:cover.png", videoUrls: videoUrlModel, playNum: "435", commentNum: "5464", duration: "1:30", videoTitle: "谷胱甘肽风格灌灌灌灌灌灌"});
            append({bigVideoUrl: "file:///root/1.mkv", bigVideoCover: "qrc:cover.png", videoUrls: videoUrlModel, playNum: "435", commentNum: "5464", duration: "1:30", videoTitle: "谷胱甘肽风格灌灌灌灌灌灌"});
            append({bigVideoUrl: "file:///root/1.mkv", bigVideoCover: "qrc:cover.png", videoUrls: videoUrlModel, playNum: "435", commentNum: "5464", duration: "1:30", videoTitle: "谷胱甘肽风格灌灌灌灌灌灌"});
        }
    }
    ListModel {
        id: videoUrlModel
        ListElement {
            videoUrl: "file:///root/2.avi"
            videoCover: "qrc:cover.png"
            playNum: "435"
            commentNum: "5464"
            duration: "1:30"
            videoTitle: "反对他那个人的突然间那个而地方突然方没有那个反检验时"
            authorName: "grae"
        }
        ListElement {
            videoUrl: "file:///root/1.mkv"
            videoCover: "file:///root/1.png"
            playNum: "435"
            commentNum: "5464"
            duration: "1:30"
            videoTitle: "grsrhtedst htrhtdgn cfghbvc"
            authorName: "grae"
        }
        ListElement {
            videoUrl: "file:///root/1.mkv"
            videoCover: "file:///root/2.png"
            playNum: "435"
            commentNum: "5464"
            duration: "1:30"
            videoTitle: "grsrhtedst htrhtdgn cfghbvc"
            authorName: "grae"
        }
        ListElement {
            videoUrl: "file:///root/1.mkv"
            videoCover: "file:///root/2.png"
            playNum: "435"
            commentNum: "5464"
            duration: "1:30"
            videoTitle: "grsrhtedst htrhtdgn cfghbvc"
            authorName: "grae"
        }
        ListElement {
            videoUrl: "file:///root/1.mkv"
            videoCover: "qrc:cover.png"
            playNum: "435"
            commentNum: "5464"
            duration: "1:30"
            videoTitle: "grsrhtedst htrhtdgn cfghbvc"
            authorName: "grae"
        }
        ListElement {
            videoUrl: "file:///root/1.mkv"
            videoCover: "qrc:cover.png"
            playNum: "435"
            commentNum: "5464"
            duration: "1:30"
            videoTitle: "grsrhtedst htrhtdgn cfghbvc"
            authorName: "grae"
        }
    }



    //busy指示器
    BusyIndicator {
        id: busyDownRefresh
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 56
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: 25
        implicitHeight: 25
        visible: false
        contentItem: QmlBusyIndicator{}
    }

    Timer{
        id: timerDownRefresh
        interval: 1000
        repeat: false
        running: false
        onTriggered: {
            busyDownRefresh.visible = false

            //下面增加数据
            videoModel.append({bigVideoUrl: "file:///root/1.mkv", bigVideoCover: "qrc:cover.png", videoUrls: videoUrlModel, playNum: "435", commentNum: "5464", duration: "1:30", videoTitle: "新增加的数据啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊"})
        }
    }

    BusyIndicator {
        id: busyUpRefresh
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: 25
        implicitHeight: 25
        visible: false
        contentItem: QmlBusyIndicator{}
    }

    Timer{
        id: timerUpRefresh
        interval: 1000
        repeat: false
        running: false
        onTriggered: {
            busyUpRefresh.visible = false

            //上面增加数据
            videoModel.insert(0, {bigVideoUrl: "file:///root/1.mkv", bigVideoCover: "qrc:cover.png", videoUrls: videoUrlModel, playNum: "435", commentNum: "5464", duration: "1:30", videoTitle: "新增加的数据啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊"})
        }
    }
}
