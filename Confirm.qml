import QtQuick 2.0
import QtQuick.Controls 2.0
import app.style 1.0

Popup {
    modal: true
    closePolicy: Popup.CloseOnEscape
    onClosed: parent.focus = true
    x: Math.round((parent.width - width) / 2) // <-- this because I wanted to use Controls 2.0 which don't have "centerIn"
    y: Math.round((parent.height - height) / 2)

    background: Rectangle {
        color: Style.popup.backgroundColor
        border.width: Style.popup.borderWidth
        border.color: Style.popup.borderColor
    }

    property var action: null
    property string message: ""

    contentItem: Item {
        Text {
            text: message
            color: Style.popup.textColor
            font.pointSize: Style.popup.textFontSize
            font.bold: Style.popup.textFontBold
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap

            // TODO: improve this positioning...
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.95
            height: parent.height / 2.0
        }

        Row {
            spacing: 10
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 10

            Button {
                text: qsTr("Confirm")
                font.pointSize: Style.buttons.textFontSize
                font.bold: Style.buttons.textFontBold
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
                onPressed: close()
            }
        }

    }
}
