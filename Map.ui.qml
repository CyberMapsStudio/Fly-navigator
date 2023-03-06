import QtQuick 2.15
import QtQuick.Controls 2.15
import QtPositioning 5.3
import QtLocation 5.15
Rectangle {


    color: "#263238"
    border.color: "#263238"

    Plugin{
        id:mapPlugin
        name:"osm"
    }
    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(37.7749, -122.4194)
        zoomLevel: 12
        MapPolyline {
            id: poli
                 path: [
                     QtPositioning.coordinate(51.5074, -0.1278), // Лондон
                     QtPositioning.coordinate(48.8566, 2.3522) // Париж
                 ]
                 line.width: 3
                 line.color: "red"
             }
        MapQuickItem {
               id: mapItem
               anchorPoint.x: markerImage.width/2
                   anchorPoint.y: markerImage.height
               // указать иконку для отображения объекта на карте
               // иконка должна находиться в папке assets
               // здесь используется иконка "map-marker.png"
               sourceItem: Image {
                   id: markerImage
                   source: "/GPS-PNG.png"
                   width: 32
                   height: 32
               }
        }
        MapQuickItem {

            id: marker
            autoFadeIn: true
            anchorPoint.x: image.width/2
                anchorPoint.y: image.height
            coordinate: QtPositioning.coordinate(37.7749, -122.4194)
            sourceItem: Image {

                id: image
                width: 40
                height: 40
                source: "GPS-PNG.png"

            }
        }
        MouseArea {
               anchors.fill: parent

               // обработчик нажатия на экран
               onClicked: {
                   // получить координаты нажатия на карте
                   var pos = map.toCoordinate(Qt.point(mouse.x, mouse.y))

                   // установить координаты объекта на карте
                   mapItem.coordinate = pos
                   poli.addCoordinate(pos)
                   // отобразить объект на карте
                   map.addMapItem(mapItem)
                   //map.addMapItem(poli)
               }

    }

    RoundButton {
        id: roundButton
        x: 267
        width: 40
        height: 40
        anchors.right: parent.right
        anchors.top: parent.top
        icon.color: "#ddffffff"
        icon.source: "dots.png"
        display: AbstractButton.IconOnly
        flat: true
        anchors.topMargin: 56
        anchors.rightMargin: 15
    }



    }
    RoundButton {
        id: plusButton
        x: 894
        width: 40
        height: 40
        text: "+"
        anchors.right: parent.right
        anchors.top: parent.verticalCenter
        anchors.rightMargin: 0
        anchors.topMargin: 0
        icon.source: "plus.png"
        display: AbstractButton.IconOnly
        flat: true
        onClicked: {
            map.zoomLevel+=.2;
        }
    }

    RoundButton {
        id: minusButton
        x: 972
        width: 40
        height: 40
        text: "-"
        anchors.right: parent.right
        anchors.top: plusButton.top
        anchors.topMargin: 80
        anchors.rightMargin: 0
        icon.source: "minus.png"
        display: AbstractButton.IconOnly
        flat: true
        onClicked: {
            map.zoomLevel-=.2;
        }
    }
    Button {
        id: addPiter
        text: "Add point"
        onClicked: {
            poli.removeCoordinate(poli.path[poli.path.length-1])
            mapItem.coordinate =poli.path[poli.path.length-1]
            map.addMapItem(mapItem)
        }
}
    Button {
        x:50
        id: deleteall
        text: "dell all"
        onClicked: {
            poli.path = []
            map.addMapItem(poli)

        }
}

    }
