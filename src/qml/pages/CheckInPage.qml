import QtQuick 2.15
import QtQuick.Layouts 1.15

import Modules.ParkingDb 1.0

import "qrc:/qml/components" as Components

Components.StackViewItem {
    child: Item {
        ParkingDb {
            id: parkingDb
        }

        RowLayout {
            anchors.fill: parent

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 40
                    spacing: 30

                    Components.CameraFrame {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        label: "Entry Camera"
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.minimumHeight: 100

                        Row {
                            anchors.centerIn: parent
                            spacing: 30

                            Components.CommonTextField {
                                id: plateNumberTextField

                                label: "Plat Nomor Kendaraan"
                            }

                            Components.DropdownButton {
                                id: vehicleTypeField

                                label: "Jenis Kendaraan"

                                model: [
                                    { text: "Mobil [M]", value: "M" },
                                    { text: "Sepeda Motor [S]", value: "S" }
                                ]
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.minimumWidth: 400
                Layout.fillHeight: true

                color: "#B00000"

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    spacing: 10

                    Components.DateTimeText {
                        id: dateTimeText

                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Components.WhiteText {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Pintu Masuk"
                    }

                    Components.DetailRow {
                        label: "Jenis Parkir"
                        value: "-"
                    }

                    Components.DetailRow {
                        label: "Member Expired"
                        value: "-"
                    }

                    Components.DetailRow {
                        label: "Nama Member"
                        value: "-"
                    }
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 30

                    Components.SubmitButton {
                        label: "Cetak Tiket"

                        onClicked: {
                            if (plateNumberTextField.text.length === 0) {
                                showErrorDialog("Silahkan masukkan plat nomor kendaraan anda")
                                return
                            }

                            if (!parkingDb.checkPlateNumberExists(plateNumberTextField.text)) {
                                parkingDb.insertParkingList(plateNumberTextField.text, vehicleTypeField.currentValue, dateTimeText.text)

                                showSuccessDialog("Check-in success", function() {
                                    navigatedBack()
                                })
                            } else {
                                showErrorDialog("Plat nomor kendaraan yang dimasukkan sudah ada dalam database!")
                            }
                        }
                    }
                }
            }
        }

        Components.BackButton {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 10
        }
    }
}
