import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: dialog

    enum AlertLevel {
        Success,
        Error
    }

    property string title
    property string text
    property int level

    signal closed()

    function close() {
        dialogItem.isOpened = false
        signalEmitter.start()
    }

    Component.onCompleted: {
        dialogItem.isOpened = true
    }

    component DialogText: Text {
        font.pixelSize: 24
        font.weight: Font.Medium
        color: "#F3EBE3"
    }

    Timer {
        id: signalEmitter
        interval: 100
        onTriggered: closed()
    }

    Rectangle {
        anchors.fill: parent
        color: "#1F1F1F"
        opacity: 0.7
    }

    MouseArea {
        anchors.fill: parent
        onClicked: close()
    }

    Item {
        id: dialogItem

        property bool isOpened: false

        anchors.centerIn: parent
        width: 500
        height: 300
        scale: isOpened ? 1.0 : 0.9

        Behavior on scale {
            NumberAnimation { duration: 100 }
        }

        states: [
            State {
                when: dialog.level === AlertDialog.AlertLevel.Success

                PropertyChanges {
                    target: dialogFrame
                    color: "#408060"
                }
            },
            State {
                when: dialog.level === AlertDialog.AlertLevel.Error

                PropertyChanges {
                    target: dialogFrame
                    color: "#804040"
                }
            }
        ]

        MouseArea {
            anchors.fill: parent
        }

        Rectangle {
            id: dialogFrame

            anchors.fill: parent
            radius: 12

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                Item {
                    id: dialogHead

                    Layout.fillWidth: true
                    Layout.minimumHeight: 50

                    DialogText {
                        anchors.centerIn: parent
                        text: dialog.title
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#2E2E2E"

                    DialogText {
                        anchors.fill: parent
                        anchors.margins: 12
                        text: dialog.text
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Rectangle {
                    Layout.preferredHeight: 80
                    Layout.fillWidth: true
                    Layout.bottomMargin: 12
                    color: "#2E2E2E"

                    Rectangle {
                        width: 150
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 20
                        radius: 24
                        color: "#707070"

                        DialogText {
                            anchors.centerIn: parent
                            text: "Tutup"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: close()
                        }
                    }
                }
            }
        }
    }
}
