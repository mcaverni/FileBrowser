import QtQuick 2.7
import app.style 1.0

Rectangle {
    id: rectangle
    color: Style.main.backgroundColor

    // the focus can be on right or on left
    property var currentLane: null
    property var otherLane: null

    onCurrentLaneChanged: {
        console.log("focus on:", currentLane);
    }

    onOtherLaneChanged: {
        console.log("focus off:", otherLane);
    }

    ButtonBar {
        id: buttonBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.topMargin: 10

        onCopy: doCopy(currentLane.selection, otherLane.selection)
        onMove: doMove(currentLane.selection, otherLane.selection)
        onRemove: doRemove(currentLane.selection)

        enabled: {
            if(currentLane !== null && currentLane.selection !== ""){
                if(otherLane !== null && otherLane.selection !== "")
                    return true;
            }
            return false;
        }
    }

    Lane {
        id: leftLane
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        anchors.top: buttonBar.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 10

        onFocusOnMe: { currentLane = leftLane; otherLane = rightLane; }
        backendData: BrowserLeft
    }

    Lane {
        id: rightLane
        anchors.left: parent.horizontalCenter
        anchors.right: parent.right
        anchors.top: buttonBar.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 10

        onFocusOnMe: { currentLane = rightLane; otherLane = leftLane; }
        backendData: BrowserRight
    }

    function doMove(fromPath, toPath){
        if(!confirm())
            return;
        console.log("moving:", fromPath, "--->", toPath);
        currentLane.move(fromPath, toPath);
    }

    function doCopy(fromPath, toPath){
        if(!confirm())
            return;
        console.log("copying:", fromPath, "--->", toPath);
        currentLane.copy(fromPath, toPath);
    }

    function doRemove(filePath){
        if(!confirm())
            return;
        console.log("deleting:", filePath);
        currentLane.copy(filePath);
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
