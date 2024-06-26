import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtPositioning 5.3
import QtQuick.Layouts 1.15
import "components" as Components
Window {
    id: window
    width: Screen.width
    height: Screen.height
    visible: true
    property var path_poli
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
            y: 727//727
            height: 72
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
                onClicked: {
                drawerRoute.open()
                }
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
                onClicked: {drawerSettings.open()}
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
        Drawer {
                id: drawerRoute
                width: 0.85 * window.width
                height: window.height
                Rectangle{
                     anchors.fill: parent
                     color: "#263238"
            Label {
                Text {
                    id: textItem
                    text: qsTr("Route menu")
                    font.family: "Arial"
                    color: "#ffffff"
                    font.pixelSize: 20
                    layer.enabled: false
                    fontSizeMode: Text.FixedSize
                    textFormat: Text.PlainText
                    anchors.left: parent.horizontalCenter
                    anchors.right: parent.horizontalCenter
                    anchors.top: parent.verticalCenter
                    anchors.bottom: parent.verticalCenter
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0

                }
            }
            Button{
                y:40
                x:150
            text:"save route"
            onClicked: {
                var orig =JSON.stringify(map_clone.poli.path.slice(1))
                var another = false
                map_clone.db.transaction(
                               function(tx) {
                                   // Create the database if it doesn't already exist
                                   var rs = tx.executeSql('SELECT * FROM routes');


                                                       for (var i = 0; i < rs.rows.length; i++) {
                                                            if(rs.rows.item(i).path == orig){
                                                            another = true
                                                                }
                                                       }


                              }
                               )

                console.log(JSON.stringify(map_clone.poli.path.slice(1)))
                if (another ==false){
                map_clone.db.transaction(
                                           function(tx) {
                                               tx.executeSql('INSERT INTO routes (path) values (?)',  [JSON.stringify(map_clone.poli.path.slice(1))] )
                                            }
                )
                refresh.clicked()
            }
            }
            }
            Button{
            y:40
            x:40
            text: "TEST ROUTE"
            onClicked:{
                var r = ""
                map_clone.db.transaction(
                               function(tx) {
                                   // Create the database if it doesn't already exist
                                   var rs = tx.executeSql('SELECT * FROM routes ORDER BY name DESC LIMIT 1;');


                                                       for (var i = 0; i < rs.rows.length; i++) {
                                                           r += rs.rows.item(i).path
                                                       }


                              }
                           )

                //map_clone.poli.path[1]=t[0]
                //console.log(t[0])
                for (let i=map_clone.poli.pathLength();map_clone.poli.pathLength()>1;i--){
                    map_clone.poli.removeCoordinate(i)
                }
                var b =JSON.parse(r)
                console.log(b)
                for(let i=0;(b.length)-1>=i;i++){
                    map_clone.poli.addCoordinate(QtPositioning.coordinate(b[i].latitude, b[i].longitude))
                    console.log(i)
                }
            }
            }
            Button{
                y:40
                x:300
                id:refresh
                text: "refresh"
                onClicked:{
                    for(var i = routesLay.children.length; i > 0 ; i--) {
                            console.log("destroying: " + i)
                            routesLay.children[i-1].destroy()}
                    map_clone.db.transaction(
                                   function(tx) {
                                       // Create the database if it doesn't already exist
                                       var rs = tx.executeSql('SELECT * FROM routes');


                                                           for (var i = 0; i < rs.rows.length; i++) {
                                                               //r += rs.rows.item(i).path
                                                               Qt.createQmlObject(`import QtQuick 2.0
                                                                                  import QtPositioning 5.3
import QtQuick.Controls 2.15

                                                   Button {
                                                       text: "ROUTE ${rs.rows.item(i).name}"
                                                       onClicked: {
                                                                                  var r = ""
                                                                                  map_clone.db.transaction(
                                                                                                 function(tx) {
                                                                                                     // Create the database if it doesn't already exist
                                                                                                     var rs = tx.executeSql('SELECT * FROM routes where name=${rs.rows.item(i).name};');


                                                                                                                         for (var i = 0; i < rs.rows.length; i++) {
                                                                                                                             r += rs.rows.item(i).path
                                                                                                                         }


                                                                                                }
                                                                                             )


                                                                                  for (let i=map_clone.poli.pathLength();map_clone.poli.pathLength()>1;i--){
                                                                                      map_clone.poli.removeCoordinate(i)
                                                                                  }
                                                                                  var b =JSON.parse(r)
                                                                                  console.log(b)
                                                                                  for(let i=0;(b.length)-1>=i;i++){
                                                                                      map_clone.poli.addCoordinate(QtPositioning.coordinate(b[i].latitude, b[i].longitude))
                                                                                      console.log(i)
                                                                                  }
                                                                              }
                                                                                  }

                                                   `,routesLay)
                                                           }


                                  }
                               )

                }
            }
            Button{
                text:"Delate all"
                y:100
                x:40
                 onClicked:{
                     map_clone.db.transaction(
                                                function(tx) {
                                                    tx.executeSql('DELETE FROM routes' )
                                                    refresh.clicked()
                                                 }
                     )


}
            }
            ColumnLayout{
                id:routesLay
                spacing: 2
                y:200

            }
        }

        }

        Drawer {

                id: drawerSettings
                width: 0.85 * window.width
                height: window.height
                edge: Qt.RightEdge
                Rectangle{
                     anchors.fill: parent
                     color: "#263238"
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
        }
                Component.onCompleted: {
                    refresh.clicked()
                }
        }
        Components.Map{
            id: map_clone
            anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: rectangle.bottom
                        anchors.bottom: row.top
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0

        }



    }



}
