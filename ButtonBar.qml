import QtQuick 2.7
import QtQuick.Controls 2.0
import app.style 1.0

Row {
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

    // ** custom properties

    // to control everything from one place
    property int buttonHeight: 30
    property int buttonWidth: 110

    property bool actionEnabled: false

    signal copy()
    signal move()
    signal remove()
    signal newFolder(var folderName)
    signal rename(var fileName)
    // **

    // stuff of the Row
    spacing: Style.buttons.spacing
    height: buttonHeight
    width: buttonWidth * 3 + spacing * 2

    Button {
        text: qsTr("Copy")
        font.pointSize: Style.buttons.textFontSize
        font.bold: Style.buttons.textFontBold
        height: parent.buttonHeight
        width: parent.buttonWidth

        enabled: parent.actionEnabled

        onClicked: copy()
    }

    Button {
        text: qsTr("Move")
        font.pointSize: Style.buttons.textFontSize
        font.bold: Style.buttons.textFontBold
        height: parent.buttonHeight
        width: parent.buttonWidth

        enabled: parent.actionEnabled

        onClicked: move()
    }

    Button {
        // stuff of the button
        text: qsTr("Delete")
        font.pointSize: Style.buttons.textFontSize
        font.bold: Style.buttons.textFontBold
        height: parent.buttonHeight
        width: parent.buttonWidth

        // a general status of the whole component, from the external
        enabled: parent.actionEnabled

        // each button's specific action to notify to the external
        onClicked: remove()
    }

    Button {
        text: qsTr("Rename")
        font.pointSize: Style.buttons.textFontSize
        font.bold: Style.buttons.textFontBold
        height: parent.buttonHeight
        width: parent.buttonWidth

        enabled: parent.actionEnabled

        onClicked: rename("test")
    }

    Button {
        text: qsTr("New Folder")
        font.pointSize: Style.buttons.textFontSize
        font.bold: Style.buttons.textFontBold
        height: parent.buttonHeight
        width: parent.buttonWidth

        enabled: parent.actionEnabled

        onClicked: newFolder("test")
    }
}
