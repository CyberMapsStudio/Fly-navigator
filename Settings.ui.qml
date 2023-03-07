import QtQuick 2.15
import QtQuick.Controls 2.15
Rectangle {
    color: "#263238"
    border.color: "#263238"

    Button {
        id: button
        text: qsTr(" ")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: switchDelegate2.bottom
        flat: true
        highlighted: false
        display: AbstractButton.TextOnly
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        Label {
            id: label7
            y: -44
            color: "#ffffff"
            text: qsTr("Выбрать режим отображения карты")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            topInset: 12
            leftPadding: 0
            topPadding: 0
            font.pointSize: 8
            leftInset: 12
            anchors.topMargin: 15
            anchors.bottomMargin: 0
        }
    }

    SwitchDelegate {
        id: switchDelegate
        text: qsTr(" ")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Label {
            id: label4
            y: -44
            text: qsTr("Отображение запретных зон")
            color: "#ffffff"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            topInset: 12
            leftPadding: 0
            topPadding: 0
            font.pointSize: 8
            leftInset: 12
            anchors.topMargin: 20
            anchors.bottomMargin: 0
        }
    }

    SwitchDelegate {
        id: switchDelegate1
        x: 0
        y: 52
        text: qsTr(" ")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: switchDelegate.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Label {
            id: label2
            y: -44
            text: qsTr("FlightRadar24")
            color: "#ffffff"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            topInset: 12
            leftPadding: 0
            topPadding: 0
            font.pointSize: 8
            leftInset: 12
            anchors.topMargin: 20
            anchors.bottomMargin: 0
        }
    }

    SwitchDelegate {
        id: switchDelegate2
        x: 0
        y: 104
        text: qsTr(" ")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: switchDelegate1.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Label {
            id: label3
            y: -44
            color: "#ffffff"
            text: qsTr("Отображение данных о полёте")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            topInset: 12
            leftPadding: 0
            topPadding: 0
            font.pointSize: 8
            leftInset: 12
            anchors.topMargin: 20
            anchors.bottomMargin: 0
        }
    }
    Button{
        onClicked: {

        }
    }
    Component.onCompleted: {
            label_te.text = "Settings"
        }

}
