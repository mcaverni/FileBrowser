import QtQuick 2.7
import QtQuick.Controls 2.0
import app.style 1.0

Column {
    /*
     * @Massimo
     * suggerimento: ugualmente, qui ho preferito racchiudere i bottoni in un componente
     * vantaggi:
     * - anchoring relativo ad un componente
     * - posso decidere di spostare il componente dove mi pare, molto velocemente
     * - eventualmente potrei sdoppiarlo: uno per ListView (cosa brutta, ma se volessi...)
     *
     * suggerimento: inoltre, i bottoni sono disabilitati, quando non hanno azioni che possono compiere (es: non ho selezionato niente da copiare, non posso copiare)
     * questo da' gia' immediatamente feedback all'utetnte
     */
    signal copy()
    signal move()
    signal remove()
    signal newFolder(var folderName)
    signal rename(var fileName)

    // to control everything from one place
    property int buttonHeight: 30
    property int buttonWidth: 110
    property bool actionsEnabled: false

    spacing: 10
    width: buttonWidth * 5 + spacing * 4

    Row {
        // stuff of the Row
        spacing: Style.buttons.spacing
        height: buttonHeight
        width: parent.width

        Button {
            text: qsTr("Copy")
            font.pointSize: Style.buttons.textFontSize
            font.bold: Style.buttons.textFontBold
            height: buttonHeight
            width: buttonWidth

            enabled: actionsEnabled

            onClicked: copy()
        }

        Button {
            text: qsTr("Move")
            font.pointSize: Style.buttons.textFontSize
            font.bold: Style.buttons.textFontBold
            height: buttonHeight
            width: buttonWidth

            enabled: actionsEnabled

            onClicked: move()
        }

        Button {
            // stuff of the button
            text: qsTr("Remove")
            font.pointSize: Style.buttons.textFontSize
            font.bold: Style.buttons.textFontBold
            height: buttonHeight
            width: buttonWidth

            // a general status of the whole component, from the external
            enabled: actionsEnabled

            // each button's specific action to notify to the external
            onClicked: remove()
        }

        Button {
            text: qsTr("Rename")
            font.pointSize: Style.buttons.textFontSize
            font.bold: Style.buttons.textFontBold
            height: buttonHeight
            width: buttonWidth

            enabled: actionsEnabled && textInput.text.length > 0

            onClicked: rename(textInput.text)
        }

        Button {
            text: qsTr("New Folder")
            font.pointSize: Style.buttons.textFontSize
            font.bold: Style.buttons.textFontBold
            height: buttonHeight
            width: buttonWidth

            enabled: actionsEnabled && textInput.text.length > 0

            onClicked: newFolder(textInput.text)
        }
    }

    Rectangle {
        width: 2 * buttonWidth + Style.buttons.spacing
        height: buttonHeight

        anchors.right: parent.right

        color: Style.input.backgroundColor
        border.width: Style.input.borderWidth
        border.color: Style.input.borderColor

        TextInput {
            id: textInput
            anchors.fill: parent
            anchors.margins: 2

            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: Style.input.textColor
            font.pointSize: Style.input.textFontSize
        }
    }
}
