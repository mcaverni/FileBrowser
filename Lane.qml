import QtQuick 2.7
import QtQuick.Controls 2.0
import app.style 1.0

Item {
    // this item can be istantiated as many times we want!

    // the external world needs to know what's selected
    property string selection: "" // when this is empty, the buttons must be disabled
    property alias text: myInputText.text
    property alias data: myListBrowser.model
    signal focusOnMe

    Rectangle {
        // dynamic, for resize: no width/height provided
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: myInputTool.top
        anchors.bottomMargin: 10 // between the bottom browser and the upper listview

        border.color: Style.list.border
        color: Style.list.background
        border.width: 2
        radius: 2

        ListView {
            id: myListBrowser
            anchors.fill: parent
            clip: true // dynamic content: better to clip it!
            onFocusChanged: { if(focus) focusOnMe(); }

            // model: will be set from outside
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

        color: Style.input.background
        border.width: 2
        border.color: Style.input.border

        Row {
            anchors.fill: parent

            TextEdit {
                id: myInputText

                height: parent.height
                width: myInputTool.width - myInputButton.width
                clip: true // dynamic content: better to clip it!

                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                color: Style.input.text

                text: "/test/of/path"

                onFocusChanged: { if(focus) focusOnMe(); }
            }

            Button {
                id: myInputButton
                height: parent.height
                width: 40
                text: qsTr("GO!")

                // dynamic enable/disable
                enabled: myInputText.text.length > 0

                onClicked: {
                    // TODO: refresh the backend
                    focusOnMe();
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
