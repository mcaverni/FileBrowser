import QtQuick 2.0

Rectangle {
    id: rectangle
    color: Style.colors.background

    // the focus can be on right or on left
    property var currentLane: null

    onCurrentLaneChanged: {
        console.log(currentLane);
    }

    ButtonBar {
        id: buttonBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.topMargin: 10
    }

    Lane {
        id: leftLane
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        anchors.top: buttonBar.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 10
        onFocusOnMe: currentLane = this
    }

    Lane {
        id: rightLane
        anchors.left: parent.horizontalCenter
        anchors.right: parent.right
        anchors.top: buttonBar.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 10
        onFocusOnMe: currentLane = this
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
