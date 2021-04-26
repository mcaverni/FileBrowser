import QtQuick 2.0
import QtQuick.Controls 2.0
import app.style 1.0

Popup {
    modal: true
    closePolicy: Popup.CloseOnEscape
    onClosed: parent.focus = true
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)

    background: Rectangle {
        color: Style.popup.backgroundColor
        border.width: Style.popup.borderWidth
        border.color: Style.popup.borderColor
    }

    property var action: null
    property string message: ""

    contentItem: Item {
        id: item1
        Text {
            text: message
            color: Style.popup.textColor
            font.pointSize: Style.popup.textFontSize
            font.bold: Style.popup.textFontBold
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height / 2
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap
        }

        Button {
            text: qsTr("Confirm")
            font.pointSize: Style.buttons.textFontSize
            font.bold: Style.buttons.textFontBold
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            onPressed: {
                if(action !== null)
                    action();
                close();
            }
        }


        Button {
            text: qsTr("Cancel")
            font.pointSize: Style.buttons.textFontSize
            font.bold: Style.buttons.textFontBold
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            onPressed: close()
        }
    }
}
