import QtQuick 2.15

import QtQuick.Window 2.15
import QtQuick.Controls 2.15
Window {
    id: window
    width: Screen.width
    height: Screen.height
    visible: true
    Rectangle {
        id: rectangle1
        width: Screen.width
        height: Screen.height
        color: "#263238"
        border.color: "#263238"


        Rectangle {
            id: rectangle
            height: 56
            color: "#1f2a2f"
            border.color: "#1f2a2f"
            border.width: 11
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            smooth: true
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0

            Label {
                id: label_te
                color: "#ddffffff"
                text: qsTr("Fly navigator")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                font.pixelSize: 20
                font.styleName: "Semibold"
                anchors.leftMargin: 45
            }
        }





        Row {
            id: row
            y: 727
            height: 73
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            spacing: 10
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0


            RoundButton {
                id: routeButton
                width: 80
                height: 72
                visible: true
                anchors.left: parent.left
                font.pixelSize: 12
                anchors.leftMargin: 20
                icon.height: 30
                icon.width: 30
                icon.color: "#ddffffff"
                flat: true
                display: AbstractButton.IconOnly
                icon.source: "route_ico.png"
                onClicked: {stack.push("Route.ui.qml")}
                Label {
                    id: routeLabel
                    color: "#ddffffff"
                    text: qsTr("Route")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 2
                    rotation: 0
                }
            }

            RoundButton {
                id: mapButton
                width: 80
                height: 72
                visible: true
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
                flat: true
                icon.height: 30
                onClicked: {stack.push("Map.ui.qml")}
                Label {
                    id: mapLabel
                    color: "#ddffffff"
                    text: qsTr("Map")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    anchors.bottomMargin: 2
                    rotation: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                }
                display: AbstractButton.IconOnly
                icon.source: "map_ico.png"
                icon.color: "#ddffffff"
                icon.width: 30
            }

            RoundButton {
                id: settingButton
                width: 80
                height: 72
                visible: true
                anchors.right: parent.right
                font.pixelSize: 12
                anchors.rightMargin: 20
                flat: true
                icon.height: 30
                onClicked: {stack.push("Settings.ui.qml")}
                Label {
                    id: settingsLabel
                    color: "#ddffffff"
                    text: qsTr("Setting")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    anchors.bottomMargin: 2
                    rotation: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                }
                display: AbstractButton.IconOnly
                icon.source: "settings_ico.png"
                icon.color: "#ddffffff"
                icon.width: 30
            }


        }

        StackView {
            id: stack
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: rectangle.bottom
            anchors.bottom: row.top
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            initialItem: Map {}
        }

    }



}
