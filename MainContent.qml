import QtQuick 2.7
import QtQuick.Controls 2.0
import app.style 1.0
import "qrc:/messages.js" as MessageProxy

Rectangle {
    id: rectangle
    color: Style.main.backgroundColor

    focus: true // to intercept "ESC"
    Keys.onEscapePressed: {
        // @selection: when ESC is pressed, the current lane is deselected as well
        if(currentLane !== null)
            currentLane.deselectItem();
        // @selection: making sure that also the other lane is deselected, won't do no harm :)
        if(otherLane !== null)
            otherLane.deselectItem();
        // @selection: this will make the buttons inactive
        currentLane = null;
        otherLane = null;
    }

    // the focus can be on right or on left
    property var currentLane: null
    property var otherLane: null

    onCurrentLaneChanged: {
        if(currentLane === null)
            console.debug("focus OFF");
        else{
            console.debug("current:  ", currentLane);
            console.debug("selection:", currentLane.selection)
        }
    }

    onOtherLaneChanged: {
        if(otherLane === null)
            console.debug("focus OFF");
        else{
            // @selection: the de-selection is handled (of course) by the MainContent item who knows which lane is selected and which not
            console.debug("other:    ", otherLane);
            otherLane.deselectItem();
        }
    }

    ButtonBar {
        id: buttonBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.topMargin: 10

        onCopy: doCopy(currentLane.selection, otherLane.text)
        onMove: doMove(currentLane.selection, otherLane.text)
        onRemove: doRemove(currentLane.selection)
        // require extra infos
        onRename: doRename(currentLane.selection, fileName)
        onNewFolder: doNewFolder(currentLane.text, folderName)

        laneSelected: currentLane !== null && otherLane !== null
        fileSelected: laneSelected && currentLane.selection !== null
    }

    Lane {
        id: leftLane
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        anchors.top: buttonBar.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 10

        // @selection: the last selected will get the priority
        onSelected: { currentLane = leftLane; otherLane = rightLane; }
        backendData: BrowserLeft
    }

    Lane {
        id: rightLane
        anchors.left: parent.horizontalCenter
        anchors.right: parent.right
        anchors.top: buttonBar.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 10

        // @selection: the last selected will get the priority
        onSelected: { currentLane = rightLane; otherLane = leftLane; }
        backendData: BrowserRight
    }

    Confirm {
        id: confirmPopup
        width: 500
        height: 200
    }

    function doCopy(fromPath, toPath){
        confirm(MessageProxy.getCopyMessage(fromPath, toPath),
                function(){
                    console.log(">>> copying:", fromPath, "--->", toPath);
                    BrowserLeft.copy(fromPath, toPath);
                }
                );
    }

    function doMove(fromPath, toPath){
        confirm(MessageProxy.getMoveMessage(fromPath, toPath),
                function(){
                    console.log(">>> moving:", fromPath, "--->", toPath);
                    BrowserLeft.move(fromPath, toPath);
                }
                );
    }

    function doRemove(thePath){
        confirm(MessageProxy.getRemoveMessage(thePath),
                function(){
                    console.log(">>> removing:", thePath);
                    BrowserLeft.remove(thePath);
                }
                );
    }

    function doNewFolder(withinFolder, folderName){
        confirm(MessageProxy.getNewFolderMessage(withinFolder, folderName),
                function (){
                    console.log(">>> creating:", folderName);
                    if(currentLane === leftLane)
                        BrowserLeft.newFolder(folderName);
                    else if(currentLane === rightLane)
                        BrowserRight.newFolder(folderName);
                    else
                        console.error("the current lane is neiter left nor right...");
                }
                );
    }

    function doRename(oldName, newName){
        confirm(MessageProxy.getRenameMessage(oldName, newName),
                function(){
                    console.log(">>> renaming:", oldName, "--->", newName);
                    if(currentLane === leftLane)
                        BrowserLeft.rename(oldName, newName);
                    else if(currentLane === rightLane)
                        BrowserRight.rename(oldName, newName);
                    else
                        console.error("the current lane is neiter left nor right...");
                }
                );
    }

    function confirm(message, action){
        confirmPopup.message = message;
        confirmPopup.action = action;
        confirmPopup.open();
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
