import QtQuick 2.0

Row {
    // here we pass model from the ListView
    property var injectedModel

    property int extraInfoWidth: 50

    width: 400
    height: 40
    spacing: 5

    Image {
        id: fileIcon
        height: parent.height
        width: parent.height
        source: injectedModel.fileIcon // TODO: set base path
    }

    Text {
        id: fileName
        height: parent.height
        width: parent.width - 3*parent.spacing - fileIcon.width - fileType.width - fileSize.width
        text: injectedModel.fileName
    }

    Text {
        id: fileType
        height: parent.height
        width: parent.extraInfoWidth
        text: injectedModel.fileType
    }

    Text {
        id: fileSize
        height: parent.height
        width: parent.extraInfoWidth
        text: injectedModel.fileSize
    }
}
