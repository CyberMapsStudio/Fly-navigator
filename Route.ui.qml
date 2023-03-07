import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.folderlistmodel 2.1
Rectangle {
    color: "#263238"
    border.color: "#263238"
    Text {
        id: textItem
        text: qsTr("Route menu")
        anchors.centerIn: parent
        font.family: "Arial"
        color: "#ffffff"
        font.pixelSize: 20
        layer.enabled: false
        fontSizeMode: Text.FixedSize
        textFormat: Text.PlainText

    }
    Component.onCompleted: {
            label_te.text = "Route"
        }
}
