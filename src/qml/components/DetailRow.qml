import QtQuick 2.15

Item {
    property string label
    property string value

    width: 350
    height: childrenRect.height

    WhiteText {
        anchors.left: parent.left
        text: label
    }

    WhiteText {
        anchors.right: parent.right
        text: value
        font.bold: true
    }
}
