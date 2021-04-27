import QtQuick 2.7
import QtQuick.Window 2.2

Window {
    width: 610
    height: 480
    minimumHeight: 480
    minimumWidth: 610
    visible: true
    title: qsTr("File Browser")

    /* @Massimo
     * primo errore: tutto nel main.qml
     *
     * nel main.qml si mette soltanto un content, e proprieta' che servono al content, o funzioni da invocare all'avvio
     * tutta la gestione del codice poi e' dentro MainContent
     */
    MainContent {
        anchors.fill: parent
    }
}
