pragma Singleton
import QtQuick 2.7

Item {
    readonly property QtObject main: QtObject {
        property color background: "blue"
        property color text: "black"
    }

    readonly property QtObject list: QtObject {
        property color background: "white"
        property color text: "black"
        property color border: "black"
    }

    readonly property QtObject input: QtObject {
        property color background: "lightyellow"
        property color text: "black"
        property color border: "black"
    }
}
