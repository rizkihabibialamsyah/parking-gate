import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: menuButton

    property string label
    property string iconSource

    signal clicked()

    width: 220
    height: 220

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: menuButton.iconSource
        }

        Text {
            Layout.fillWidth: true
            Layout.fillHeight: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: label
            font.pixelSize: 30
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: menuButton.clicked()
    }
}
