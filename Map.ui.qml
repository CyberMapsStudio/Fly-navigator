import QtQuick 2.15
import QtQuick.Controls 2.15
import QtPositioning 5.3
import QtLocation 5.6
Rectangle {


    color: "#263238"
    border.color: "#263238"

    Plugin{
        id:mapPlugin
        name:"osm"
    }
    Map{
        anchors.fill: parent
        id:mapView
        plugin: mapPlugin


    }
}
