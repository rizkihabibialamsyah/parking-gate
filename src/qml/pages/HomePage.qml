import QtQuick 2.15

import "qrc:/qml/components" as Components

Components.StackViewItem {
    Row {
        anchors.centerIn: parent
        spacing: 40

        Components.MenuButton {
            label: "Check-in"
            iconSource: "qrc:/images/in.png"
            onClicked: navigatedTo("qrc:/qml/pages/CheckInPage.qml")
        }

        Components.MenuButton {
            label: "Check-out"
            iconSource: "qrc:/images/out.png"
            onClicked: navigatedTo("qrc:/qml/pages/CheckOutPage.qml")
        }
    }
}
