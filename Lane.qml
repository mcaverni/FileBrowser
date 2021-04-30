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
    property var selection: null // when this is empty, the buttons must be disabled
    property var backendData
    property alias text: myInputText.text
    signal selected

    states: [
        State {
            name: "pathError"
            PropertyChanges {
                target: myInputTool
                border.color: Style.input.borderColorError
            }
        }
    ]

    Connections {
        target: backendData
        onWrongPathRequested: state = "pathError"
        onRightPathRequested: state = ""
        onCurrentPathChanged: {
            // display always the correct path ("up" and "down" operations may change it)
            myInputText.text = backendData.currentPath
            state = ""
        }
    }

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
            anchors.margins: 3
            currentIndex: -1
            clip: true // variable height of content: better to clip it!



            model: backendData

            delegate: RowDelegate {
                width: myListBrowser.width
                onItemClicked: selectItem(index, name)
                onItemDoubleClicked: doubleClickItem(index, name)
            }

            highlight: Rectangle {
                color: Style.list.highlightColor
                opacity: Style.list.highlightOpacity
            }

            ScrollBar.vertical: ScrollBar{}
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
        border.width: Style.input.borderWidth
        border.color: Style.input.borderColor

        Row {
            anchors.fill: parent
            anchors.margins: 4
            spacing: 5

            TextInput {
                id: myInputText

                height: parent.height
                width: myInputTool.width - myInputButton.width - parent.anchors.margins * 2 - parent.spacing
                clip: true // dynamic content: better to clip it!

                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                color: Style.input.textColor
                font.pointSize: Style.input.textFontSize

                text: String(backendData.currentPath) // not binding the Q_PROPERTY, only a string to begin execution

                Keys.onReturnPressed: changeCurrentPath()
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

                onClicked: changeCurrentPath()
            }
        }
    }

    function changeCurrentPath() {
        deselectItem();
        backendData.currentPath = myInputText.text;
        selected();
    }

    function selectItem(index, name){
        if(index === 0)
            deselectItem();
        else{
            myListBrowser.currentIndex = index;
            selection = name;
            selected();
        }
    }

    function deselectItem(){
        myListBrowser.currentIndex = -1;
        selection = null;
    }

    function doubleClickItem(index, name){
        if(index === 0)
            backendData.up();
        else
            backendData.down(name);
        deselectItem();
        selected();
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:400;width:300}
}
##^##*/
