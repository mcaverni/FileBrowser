pragma Singleton
import QtQuick 2.7

Item {
    readonly property QtObject main: QtObject {
        property color backgroundColor: "lightgray"
        property color borderColor: "black"
        property int borderWidth: 2

        property color textColor: "black"
        property int textFontSize: 12 // points
        property bool textFontBold: false
    }

    readonly property QtObject input: QtObject {
        property color backgroundColor: "lightyellow"
        property color borderColor: "black"
        property color borderColorError: "red"
        property int borderWidth: 2

        property color textColor: "black"
        property int textFontSize: 12 // points
        property bool textFontBold: false
    }

    readonly property QtObject popup: QtObject {
        property color backgroundColor: "#d8f0f2"
        property color borderColor: "black"
        property int borderWidth: 2

        property color textColor: "black"
        property int textFontSize: 14 // points
        property bool textFontBold: false
    }

    readonly property QtObject buttons: QtObject {
        property int spacing: 10
        property int textFontSize: 16 // points
        property bool textFontBold: true
    }

    readonly property QtObject list: QtObject {
        property color backgroundColor: "white"
        property color borderColor: "black"
        property int borderWidth: 2

        property color highlightColor: "cyan"
        property double highlightOpacity: 0.4

        property color textColor: "black"
        property int textFontSize: 12 // points
        property bool textFontBold: false

        property int iconSize: 10 // height = width
        property string iconFile: ""
        property string iconFolder: ""
        property string iconLink: ""
    }

    states: [
        State{
            name: "darkmode"
            // TODO: define another style
        }
    ]
}
