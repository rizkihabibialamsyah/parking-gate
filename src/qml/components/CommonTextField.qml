import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Item {
    property string label
    property alias text: textField.text
    property alias readOnly: textField.readOnly

    width: 300
    height: 80

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

            TextField {
                id: textField

                Layout.fillWidth: true
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20

                background: Rectangle {
                    radius: 10
                }
            }
        }
    }
}
