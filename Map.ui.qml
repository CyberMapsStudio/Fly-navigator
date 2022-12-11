import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {


    color: "#263238"
    border.color: "#263238"
    Text {
        id: textItem
        text: qsTr("Maps doesn't download")
        anchors.centerIn: parent
        font.family: "Arial"
        color: "#ffffff"
        font.pixelSize: 20
        layer.enabled: false
        fontSizeMode: Text.FixedSize
        textFormat: Text.PlainText

    }
}
