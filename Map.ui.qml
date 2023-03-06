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
        center: QtPositioning.coordinate(47.21276881282476, 38.915922528876514)
        zoomLevel: 12


        MapPolyline {
            id: poli
                 path: [
                    QtPositioning.coordinate(positionSource.position.coordinate.latitude, positionSource.position.coordinate.longitude),
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
        MapQuickItem {

            id: marker_gps
            autoFadeIn: true
            anchorPoint.x: imageGPS.width/2
                anchorPoint.y: imageGPS.height

            sourceItem: Image {

                id: imageGPS
                width: 40
                height: 40
                source: "placeholder.png"

            }
        }
        PositionSource {
            id: positionSource

            // Установка типа источника данных

            // Свойства для хранения текущих координат
            property real latitude: 0
            property real longitude: 0

            // Подключение к сигналу для получения обновлений координат
            onPositionChanged: {
                latitude = position.coordinate.latitude
                longitude = position.coordinate.longitude
                marker_gps.coordinate = QtPositioning.coordinate(latitude, longitude)
                map.addMapItem(marker_gps)
            }

            // Инициализация QGeoPositionInfoSource
            Component.onCompleted: {
                positionSource.source = QtPositioning.QGeoPositionInfoSource.createDefaultSource()
                positionSource.start()
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

    Button {
        x:100
        id: gps_first_dot
        text: "first= GPS"
        onClicked: {
            poli.path[0]= QtPositioning.coordinate(positionSource.position.coordinate.latitude, positionSource.position.coordinate.longitude)
            map.addMapItem(poli)

        }
}
    RoundButton {
        x: 300
                    id: northButton
                    //icon.source: "qrc:/arrow.png"
                    icon.width: 30
                    icon.height: 30

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.top
                        topMargin: 16
                    }
                    onClicked: {
                        map.setBearing(0,map.center);
                    }
                }

    }
