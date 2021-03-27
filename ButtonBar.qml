import QtQuick 2.0
import QtQuick.Controls 2.0

Row {
    // ** custom properties

    // to control everything from one place
    property int buttonHeight: 80
    property int buttonWidth: 150

    property bool actionEnabled: false

    signal copy()
    signal move()
    signal remove()
    // **

    // stuff of the Row
    spacing: 20
    height: buttonHeight
    width: buttonWidth * 3 + spacing * 2

    Button {
        id: copy
        text: qsTr("copy")
        height: parent.buttonHeight
        width: parent.buttonWidth

        enabled: parent.actionEnabled

        onClicked: copy()
    }
    Button {
        id: move
        text: qsTr("move")
        height: parent.buttonHeight
        width: parent.buttonWidth

        enabled: parent.actionEnabled

        onClicked: move()
    }
    Button {
        // stuff of the button
        id: remove
        text: qsTr("remove")
        height: parent.buttonHeight
        width: parent.buttonWidth

        // a general status of the whole component, from the external
        enabled: parent.actionEnabled

        // each button's specific action to notify to the external
        onClicked: remove()
    }
}
