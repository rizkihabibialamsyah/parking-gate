import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    property string label

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: "#808080"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 5

            WhiteText {
                text: label
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 10

                Image {
                    anchors.centerIn: parent
                    source: "qrc:/images/camera.png"
                }
            }
        }
    }
}
