import QtQuick 2.7
import app.style 1.0

Row {
    // here we pass model from the ListView
    property int extraInfoWidth: 50

    /*
     * provide: icon, name, type, size
     * (as texts)
     */

    height: 15
    spacing: 5

    Image {
        id: fileIcon
        height: parent.height
        width: parent.height
        source: icon // TODO: set base path
    }

    Text {
        id: fileName
        height: parent.height
        width: parent.width - 3*parent.spacing - fileIcon.width - fileType.width - fileSize.width
        color: Style.list.textColor
        text: name
    }

    Text {
        id: fileType
        height: parent.height
        width: parent.extraInfoWidth
        color: Style.list.textColor
        text: type
    }

    Text {
        id: fileSize
        height: parent.height
        width: parent.extraInfoWidth
        color: Style.list.textColor
        text: size
    }
}
