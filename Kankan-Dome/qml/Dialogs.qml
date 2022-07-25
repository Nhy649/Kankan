import QtQuick
import QtQuick.Dialogs

Item {
    property alias fileImageDialog: fileImageDialog
    FileDialog{
        id: fileImageDialog
        title: "请选择一张图片"
        nameFilters: ["Image files (*.png *.jpeg *.jpg)"]
        onAccepted: {
            accountInfor.imageSource = fileImageDialog.currentFile
            //存储到数据库中

        }
    }
}
