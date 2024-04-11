import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Parking Gate")

    Item {
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            color: "#F0F0F0"
        }

        StackView {
            id: mainStackView

            anchors.fill: parent
            initialItem: "qrc:/qml/pages/HomePage.qml"

            pushEnter: Transition {
                ScaleAnimator {
                    from: 0.9
                    to: 1
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            pushExit: Transition {}

            popEnter: Transition {
                ScaleAnimator {
                    from: 1.1
                    to: 1
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            popExit: Transition {}
        }

        Connections {
            target: mainStackView.currentItem

            function onNavigatedTo(url) {
                mainStackView.push(url)
            }

            function onNavigatedBack(url) {
                mainStackView.pop()
            }
        }
    }
}
