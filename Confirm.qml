import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle {
    height: 200
    width: 200

    property alias text: message.text

    signal confirm()
    signal cancel()

    Rectangle {
        id: rectangle

        Text {
            id: message
            width: 200
            height: 40
            anchors.centerIn: parent
        }

        Button {
            height: 30
            width: 50
            text: qsTr("Yes")
            anchors.right: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.rightMargin: -100
            onClicked: confirm()
        }

        Button {
            height: 30
            width: 50
            text: qsTr("No")
            anchors.left: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.leftMargin: 100
            onClicked: cancel()
        }
    }
}


