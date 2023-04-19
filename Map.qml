import QtQuick 2.15
import QtQuick.Controls 2.15
import QtPositioning 5.3
import QtLocation 5.15
import QtSensors 5.0
import QtQuick.LocalStorage 2.15

Rectangle {
    id:rooter
    color: "#263238"
    border.color: "#263238"
    property var db : LocalStorage.openDatabaseSync("myDB","1.0","mydatabase",100000)
    property int counter_poli: 0;

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
                objectName: "poli"

                 line.width: 3
                 line.color: "red"
                 signal poliSignal()
                 function changePath(stroka){
                    poli.path = JSON.parse(stroka)
                 }
             }
        MapQuickItem {
               id: mapItem
               anchorPoint.x: markerImage.width/2
                   anchorPoint.y: markerImage.height
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
            active: true
            onPositionChanged: {
                console.log("Coordinate:", position.coordinate);
                marker_gps.coordinate = position.coordinate
                map.addMapItem(marker_gps)
                map.addMapItem(poli)
                if (1){
                    poli.replaceCoordinate(0,positionSource.position.coordinate)
                }
                if (closeLocation.checked){

                    map.center= positionSource.position.coordinate
                }

                if (poli.pathLength() !== 1){
                    if (positionSource.position.coordinate.distanceTo(poli.path[1])<=100){
                        poli.removeCoordinate(1)
                    }
                }


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
                   var totalDistance = 0
                   var previousPoint = poli.path[0]
                           for (var i = 0; i < poli.pathLength(); i++) {
                               var currentPoint = poli.path[i]
                               var distance = QtPositioning.coordinate(previousPoint.latitude, previousPoint.longitude)
                                   .distanceTo(QtPositioning.coordinate(currentPoint.latitude, currentPoint.longitude))
                               totalDistance += distance
                               previousPoint = currentPoint
                           }
                           var finalDistance = totalDistance + QtPositioning.coordinate(previousPoint.latitude, previousPoint.longitude)
                               .distanceTo(QtPositioning.coordinate(poli.path[poli.pathLength()-1].latitude,poli.path[poli.pathLength()-1].longitude))
                           console.log("Distance: " + finalDistance + " meters")

                            leng_text.text="Distance: " + Math.round(finalDistance) + " meters" + Math.round(finalDistance)/1000+ " Km"

                           Qt.createQmlObject(`
                               import QtQuick 2.0

                               Rectangle {
                                              x:${counter_poli}*50
                                   color: "red"
                                   width: 20
                                   height: 20
                               }
                               `,
                               rooter,
                               "myDynamicSnippet"
                           );
                           counter_poli++





               }

    }

        RoundButton {
                id: dotsButton
                width: 30
                height: 30
                flat: true
                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: 15
                    rightMargin: 15

                }
                Image {
                        source: "dots.png"
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                    }
            }



    }
    RoundButton{
                        id: northButton
                        width: 40
                        height: 40
                        flat: true
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                            topMargin: 10
                        }
                        Image{
                            source: "arrow.png"
                                    anchors.fill: parent
                                    fillMode: Image.PreserveAspectFit
                        }


                        onClicked: {
                            map.setBearing(0,map.center);
        }
        }
    Button{
    id:print_b
    y: 200
    text: "Print_route"
    onClicked: {
        console.log(JSON.stringify(poli.path))
        console.log(typeof poli.path[0])


    }
    }

    Label{
        y:300
        id: leng_text
    }
    Column {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 10

            }
            spacing: 10
            Image{
                id: plusButton
                width: 40
                height: 40
                source: "plus.png"
                MouseArea{
                anchors.fill: parent
                onClicked: {
                    map.zoomLevel+=.2;
                }
            }
    }
            Image {
                id: minusButton

                width: 40
                height: 40

                source: "minus.png"
                MouseArea{
                    anchors.fill: parent
                onClicked: {
                    map.zoomLevel-=.2;
                }
            }
            }
            Image {
                id: removeway
                width: 40
                height: 40

                source: "delone.png"
                MouseArea{
                    anchors.fill: parent
                onClicked: {
                    if (poli.pathLength() !== 1){
                    poli.removeCoordinate(poli.path[poli.path.length-1])
                    mapItem.coordinate =poli.path[poli.path.length-1]
                    map.addMapItem(mapItem)
                    }




                }
        }
            }
            Image {
                id: deleteall
                width: 40
                height: 40

                source: "delall.png"
                MouseArea{
                    anchors.fill: parent
                onClicked: {
                    poli.path = []
                    map.addMapItem(poli)
                    leng_text.text="Distance: " + "0" + " meters" + "0"+ " Km"
                    poli.addCoordinate(positionSource.position.coordinate)

                }
                }
        }
            Image {
                    id: centerButton
                    width: 40
                    height: 40

                    source: "me.png"
                    MouseArea{
                        anchors.fill: parent
                    onClicked: {
                        map.center = positionSource.position.coordinate;
                        map.zoomLevel = 12;
                    }
                }
            }
        }
    Button {
    onClicked:{
        var routePath = QtPositioning.geoPath()
        routePath.addCoordinate(poli.path[0])
        routePath.addCoordinate(poli.path[1])
        var routeInfo = QtPositioning.gpxRoute()
        routeInfo.name = "My Route"
        routeInfo.description = "A description of my route"
        routeInfo.startTime = new Date()
        routeInfo.endTime = new Date()

        var gpxDoc = QtPositioning.gpxDocument()
        gpxDoc.routes.push(routeInfo)
        gpxDoc.tracks.push(routePath)
        var file = new QFile("myroute.gpx")
        file.open(QIODevice.WriteOnly | QIODevice.Text)
        var stream = new QTextStream(file)
        stream.writeString(gpxDoc.toString())
        file.close()

    }
    }
    Switch{
        id: closeLocation


    }
    Button{
    x:50
        onClicked: {
            db.transaction(
                           function(tx) {
                               // Create the database if it doesn't already exist
                               tx.executeSql('CREATE TABLE IF NOT EXISTS tables(salutation TEXT, salutee TEXT)');
                           }
                       )


    }
    }
    Button{
    x:200
    text:"print"
        onClicked: {
            db.transaction(
                           function(tx) {
                               // Create the database if it doesn't already exist
                               var rs = tx.executeSql('SELECT * FROM tables');

                                                   var r = ""
                                                   for (var i = 0; i < rs.rows.length; i++) {
                                                       r += rs.rows.item(i).salutation + ", " + rs.rows.item(i).salutee + "\n"
                                                   }

                                                   console.log(r)
                           }
                       )


    }
    }

    Button{
    x:300
    text:"+++++++"
        onClicked: {
            db.transaction(
                           function(tx) {
                               // Create the database if it doesn't already exist
                              tx.executeSql('INSERT INTO tables VALUES(?, ?)', [ 'hello', 'world' ]);
                           }
                       )


    }
    }
    Component.onCompleted: {

            poli.path= [positionSource.position.coordinate]
            label_te.text = "Map"
        }

    }
