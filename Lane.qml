import QtQuick 2.7
import QtQuick.Controls 2.0
import app.style 1.0

Item {
    /*
     * @Massimo
     * secondo errore: la parte destra e la parte sinistra sono esattamente uguali
     *
     * quello che cambia e' il contenuto, il back-end, ma lato front-end si puo' fattorizzare tutto
     * ovvero invece che avere due ListView con due TextEdit sotto, si puo' raggruppare tutto in un unico componente
     *
     * questo porta il vantaggio di
     * - edit veloce del codice (modifico solo la classe, non devo fare il lavoro su 2 ListView e 2 TextEdit, ma su 1 e 1
     * - facilita': le interazioni tra ListView e TextEdit sono "racchiuse" nella classe, non c'e' ambiguita' (ad esempio TextEdit sx che per sbaglio fa cose su ListView dx)
     */


    // this item can be istantiated as many times we want!

    // the external world needs to know what's selected
    property string selection: "" // when this is empty, the buttons must be disabled
    property alias text: myInputText.text
    property var backendData
    signal focusOnMe

    Rectangle {
        // dynamic, for resize: no width/height provided
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: myInputTool.top
        anchors.bottomMargin: 10 // between the bottom browser and the upper listview

        border.color: Style.list.borderColor
        border.width: Style.list.borderWidth
        color: Style.list.backgroundColor
        radius: 2

        ListView {
            id: myListBrowser
            anchors.fill: parent
            clip: true // dynamic content: better to clip it!
            onFocusChanged: { if(focus) focusOnMe(); }

            model: backendData

            delegate: RowDelegate {
                width: myListBrowser.width
            }
        }
    }




    Rectangle {
        id: myInputTool
        height: 30
        // dynamic, for resize: no width provided, only height
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        color: Style.input.backgroundColor
        border.width: 2
        border.color: Style.input.borderColor

        Row {
            anchors.fill: parent
            anchors.margins: 4

            TextEdit {
                id: myInputText

                height: parent.height
                width: myInputTool.width - myInputButton.width - parent.anchors.margins * 2
                clip: true // dynamic content: better to clip it!

                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                color: Style.input.textColor
                font.pointSize: Style.input.textFontSize

                text: "/test/of/path"

                onFocusChanged: { if(focus) focusOnMe(); }
            }

            Button {
                id: myInputButton
                height: parent.height
                width: 80
                text: qsTr("Open")

                font.bold: Style.buttons.textFontBold
                font.pointSize: Style.buttons.textFontSize

                // dynamic enable/disable
                enabled: myInputText.text.length > 0

                onClicked: {
                    focusOnMe();
                    backendData.browse(myInputText.text);
                }
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:400;width:300}
}
##^##*/
