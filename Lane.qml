import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: rectangle

    // this item can be istantiated as many times we want!

    // the external world needs to know what's selected
    property string selectedItemPath: "" // when this is empty, the buttons must be disabled
    property alias textBrowserPath: myTextBrowser.text


   signal focusOnMe

    Rectangle {
        id: myNavigator

        // dynamic, for resize: no width/height provided
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: myBrowser.top
        anchors.bottomMargin: 10 // between the bottom browser and the upper listview

        border.color: "black"
        border.width: 2
        radius: 2

        ListView {
            id: myListNavigator
            anchors.fill: parent
            clip: true // dynamic content: better to clip it!
            onFocusChanged: {if(focus) focusOnMe();}

            delegate: RowDelegate {
                injectedModel: modelData
            }
        }
    }



    Row {
        id: myBrowser
        height: 50
        // dynamic, for resize: no width provided, only height
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        TextEdit {
            id: myTextBrowser

            height: parent.height
            width: myNavigator.width - myGoButton.width
            clip: true // dynamic content: better to clip it!

            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            color: Style.colors.text

            onFocusChanged: {if(focus) focusOnMe();}
        }

        Button {
            id: myGoButton
            height: parent.height
            width: 40
            text: qsTr("GO!")

            // dynamic enable/disable
            enabled: myTextBrowser.text.length > 0

            onClicked: {
                // TODO: refresh the backend
                focusOnMe();
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:400;width:300}
}
##^##*/
