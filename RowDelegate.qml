import QtQuick 2.7
import app.style 1.0

Item {
    signal itemClicked(var index, var name)
    signal itemDoubleClicked(var index, var name)
    property string absolutePath: path

    height: 15
    width: 500 // must be redefined from outside

    Row {
        // here we pass model from the ListView
        property int extraInfoWidth: 50

        /*
         * provide: icon, name, type, size
         * (as texts)
         */
        anchors.fill: parent
        spacing: 5

        Image {
            id: fileIcon
            height: parent.height - 2
            width: parent.height - 2
            anchors.verticalCenter: parent.verticalCenter
            source: icon
        }

        Text {
            id: fileName
            height: parent.height
            width: parent.width - 3*parent.spacing - fileIcon.width - fileType.width - fileSize.width
            color: Style.list.textColor
            text: name
            elide: Text.ElideRight
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

    MouseArea {
        onClicked: itemClicked(index, name)
        onDoubleClicked: itemDoubleClicked(index, name)
        anchors.fill: parent
    }
}
