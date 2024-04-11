import QtQuick 2.15

Item {
    id: backButton

    width: 40
    height: 40

    Rectangle {
        anchors.fill: parent
        radius: 20
        color: "#808080"

        Image {
            anchors.centerIn: parent
            source: "qrc:/images/back.png"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: navigatedBack()
    }
}
