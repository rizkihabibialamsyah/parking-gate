import QtQuick 2.15

Item {
    id: submitButton

    property string label

    signal clicked()

    width: 350
    height: 60

    Rectangle {
        anchors.fill: parent
        radius: 30
        color: "#FFFFFF"

        Text {
            anchors.centerIn: parent
            text: submitButton.label
            font.pixelSize: 24
            font.bold: true
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: submitButton.clicked()
    }
}
