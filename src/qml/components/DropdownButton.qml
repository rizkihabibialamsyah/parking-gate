import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.3

Item {
    id: dropdownButton

    property string label
    property alias model: comboBox.model
    property var initialValue
    readonly property var currentValue: model[currentIndex].value
    property alias currentIndex: comboBox.currentIndex
    property bool readOnly: false

    signal valueChanged(var value)

    function setValue(value) {
        for (let i = 0; i < model.length; i++) {
            if (model[i].value === value) {
                currentIndex = i
                break
            }
        }
    }

    width: 300
    height: 80
    enabled: !readOnly

    Component.onCompleted: {
        setValue(initialValue)
    }

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

            ComboBox {
                id: comboBox

                property int popupHeight: 0

                Layout.fillWidth: true
                Layout.fillHeight: true
                textRole: "text"
                font.pixelSize: 20

                delegate: ItemDelegate {
                    width: comboBox.width
                    contentItem: Text {
                        text: comboBox.textRole ? (Array.isArray(comboBox.model) ? modelData[comboBox.textRole] : model[comboBox.textRole]) : modelData
                        font: comboBox.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: comboBox.highlightedIndex === index
                }

                indicator: Canvas {
                    id: canvas
                    x: comboBox.width - width - comboBox.rightPadding
                    y: comboBox.topPadding + (comboBox.availableHeight - height) / 2
                    width: 12
                    height: 8
                    contextType: "2d"

                    Connections {
                        target: comboBox

                        function onPressedChanged() {
                            canvas.requestPaint()
                        }
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = "#808080"
                        context.fill();
                    }
                }

                contentItem: Text {
                    leftPadding: 10
                    rightPadding: comboBox.indicator.width + comboBox.spacing

                    text: comboBox.displayText
                    font: comboBox.font
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    color: readOnly ? "#808080" : "#000000"
                }

                background: Rectangle {
                    implicitWidth: 120
                    implicitHeight: 40
                    radius: 10
                }

                popup: Popup {
                    y: comboBox.height - 1
                    width: comboBox.width
                    implicitHeight: list.implicitHeight
                    padding: 1

                    background: Item { }

                    Rectangle {
                        anchors.fill: parent
                        radius: 10
                        border.width: 1
                        border.color: "#808080"

                        ListView {
                            id: list

                            anchors.fill: parent
                            clip: true
                            implicitHeight: contentHeight
                            spacing: 2
                            model: comboBox.popup.visible ? comboBox.model : null
                            currentIndex: comboBox.highlightedIndex

                            ScrollIndicator.vertical: ScrollIndicator {}

                            delegate: ItemDelegate {
                                height: comboBox.height
                                width: comboBox.width
                                contentItem: Text {
                                    text: comboBox.textRole ? (Array.isArray(comboBox.model) ? modelData[comboBox.textRole] : model[comboBox.textRole]) : modelData
                                    font: comboBox.font
                                    elide: Text.ElideRight
                                    opacity: pressed ? 0.5 : 1
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onClicked: {
                                    comboBox.currentIndex = index
                                    comboBox.activated(index);
                                    comboBox.popup.close()
                                }

                                background: Item {
                                    visible: index < comboBox.model.length - 1
                                    anchors.fill: parent

                                    Rectangle {
                                        anchors.bottom: parent.bottom
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        height: 1
                                        width: parent.width - 2
                                        color: "#808080"
                                    }
                                }
                            }
                        }
                    }
                }

                onActivated: {
                    dropdownButton.valueChanged(model[index].value)
                }
            }
        }
    }
}
