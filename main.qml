import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 1920
    height: 810
    onBeforeRendering: Work.start();


    Rectangle{
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.2; color: "darkgrey" }
            GradientStop { position: 1.2; color: "white" }
        }

        Rectangle{
            color: "transparent"
            height: 700
            width: 700
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            transform: Rotation { origin.x: 0; origin.y: 0; axis { x: 0; y: 1; z: 0 } angle: 20}

            Image {
                id: rpmneedle
                property double angle: 179.5
                source: "qrc:/gauges/needle.png"
                anchors.verticalCenterOffset: -275
                anchors.horizontalCenterOffset: -1.5
                anchors.centerIn: rpm
                transform: Rotation { origin.x: 25; origin.y: 330; axis { x: 0; y: 0; z: 1 } angle: rpmneedle.angle }
                smooth: true
            }

            Rectangle{
                id: fuelrect
                height: 130
                width: 87
                anchors.centerIn: parent
                color: "transparent"
                anchors.verticalCenterOffset: -60
                anchors.horizontalCenterOffset: 20.3
                radius: 10

                Rectangle{
                    id: fuelprogressbar
                    property int fuelpercentage: 0
                    radius: 10
                    anchors.bottom: parent.bottom
                    color: "lightgreen"
                    width: parent.width
                    height: parent.height * (fuelprogressbar.fuelpercentage * .01)

                }

                Text {
                    id: fuelpercent
                    anchors.centerIn: fuelrect
                    anchors.verticalCenterOffset: 15
                    font.family: "Arial"
                    text: "--%"
                    font.pointSize: 20
                    color: "#0059ff"
                    font.bold: true
                }
            }

            Image{
                id: rpm
                source: "qrc:/gauges/RPMGauge.png"
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                height: 750
                anchors.bottomMargin: -50
                anchors.leftMargin: 0
                width: 750


                Image{
                    id: tempneedle
                    property int angle: 270
                    height: 100
                    width: 100
                    source: "qrc:/gauges/tempneedle.png"
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: -5
                    anchors.verticalCenterOffset: 30
                    transform: Rotation { origin.x: 50; origin.y: 65; axis { x: 0; y: 0; z: 1 } angle: tempneedle.angle}
                }

                Text{
                    id: texttemp
                    anchors.centerIn: tempneedle
                    anchors.verticalCenterOffset: 15
                    font.pointSize: 22
                    color: "#0059ff"
                    text: "--"
                    font.family: "Calibri"
                }

            }

        }

        Rectangle{
            color: "transparent"
            height: 700
            width: 700
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            transform: Rotation { origin.x: 750; origin.y: 0; axis { x: 0; y: 1; z: 0 } angle: -20 }


            Image {
                id: mphneedle
                property double angle: 180
                x: 300
                y: 45
                source: "qrc:/gauges/needle.png"
                transform: Rotation { origin.x: 25; origin.y: 330; axis { x: 0; y: 0; z: 1 } angle: mphneedle.angle}
                smooth: true
            }


            Image{
                id: mph
                x: 96
                y: -31
                source: "qrc:/gauges/MPHGauge.png"
                anchors.top: parent.top
                anchors.right: parent.right
                height: 750
                anchors.rightMargin: 0
                anchors.topMargin: 0
                width: 750

                Text{
                    id: liveMPH
                    anchors.centerIn: parent
                    font.pointSize: 80
                    color: "#0059ff"
                    text: "0"
                    font.family: "Calibri"
                    anchors.verticalCenterOffset: -10
                }
            }
        }
    }
    Connections{
        target: Work
        onObdRPM: rpmneedle.angle = rpm * 0.045 + 179.5
        onObdMPH: {liveMPH.text = speed - 1; mphneedle.angle = (speed - 1) * 2.25 + 180}
        onObdFuelStatus: {fuelprogressbar.fuelpercentage = fuel; fuelpercent.text = fuel - 3 + "%"}
        onObdCoolantTemp: {tempneedle.angle = (coolantTemp * (-9/14)) - 90; texttemp.text = ((coolantTemp - 40) * 1.8 + 32).toFixed(0)}
        //onObdThrottlePosition: liveThrottlePosition.text = "Throttle: " + throttle + "%"
        //onObdTroubleCode: liveTroubleCode.text = troublecode
    }

}
