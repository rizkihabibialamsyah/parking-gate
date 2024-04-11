import QtQuick 2.15
import QtQuick.Layouts 1.15

import Modules.ParkingDb 1.0

import "qrc:/qml/components" as Components

Components.StackViewItem {
    child: Item {
        ParkingDb {
            id: parkingDb
        }

        Timer {
            interval: 1000
            running: true
            repeat: true

            onTriggered: {
                const plateNumber = plateNumberTextField.text

                if (plateNumber.length > 0 && plateNumber != payButton.selectedPlateNumber) {
                    const data = parkingDb.selectByPlateNumber(plateNumber)
                    if (data.length > 0) {
                        vehicleTypeField.setValue(data[2])
                        parkingSlipNumberTextField.text = data[0]

                        checkInTime.value = data[3]
                        checkOutTime.value = dateTimeText.text
                        const msecDiff = new Date(checkOutTime.value) - new Date(checkInTime.value)
                        const minDiff = msecDiff / (60 * 1000)
                        const pricePerHour = 3000
                        const price = Math.ceil(minDiff / 60) * pricePerHour
                        session.value = "Rp " + price + ",00"
                        totalText.text = "Rp " + price + ",00"

                        let day = Math.floor(minDiff / (24 * 60))
                        let hour = Math.floor((minDiff % (24 * 60)) / 60)
                        let minute = Math.floor(minDiff % 60)

                        if (day == 0) {
                            duration.value = hour + " jam " + minute + " menit"
                        } else {
                            duration.value = day + " hari " + hour + " jam " + minute + " menit"
                        }

                        payButton.selectedPlateNumber = plateNumber
                    }
                }
            }
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

                    Item {
                        id: cameraFrameArea

                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        GridLayout {
                            anchors.fill: parent
                            columns: 2
                            columnSpacing: 8
                            rowSpacing: 8

                            Components.CameraFrame {
                                Layout.preferredWidth: (cameraFrameArea.width - 8) / 2
                                Layout.preferredHeight: (cameraFrameArea.height - 8) / 2
                                label: "Entry Camera"
                            }

                            Components.CameraFrame {
                                Layout.preferredWidth: (cameraFrameArea.width - 8) / 2
                                Layout.preferredHeight: (cameraFrameArea.height - 8) / 2
                                label: "Exit Camera"
                            }

                            Components.CameraFrame {
                                Layout.preferredWidth: (cameraFrameArea.width - 8) / 2
                                Layout.preferredHeight: (cameraFrameArea.height - 8) / 2
                                label: "Face Entry Camera"
                            }

                            Components.CameraFrame {
                                Layout.preferredWidth: (cameraFrameArea.width - 8) / 2
                                Layout.preferredHeight: (cameraFrameArea.height - 8) / 2
                                label: "Face Exit Camera"
                            }
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.minimumHeight: 180

                        Column {
                            anchors.centerIn: parent
                            spacing: 20

                            Row {
                                spacing: 18

                                Components.CommonTextField {
                                    id: plateNumberTextField

                                    label: "Plat Nomor Kendaraan"
                                }

                                Components.DropdownButton {
                                    id: vehicleTypeField

                                    readOnly: true
                                    label: "Jenis Kendaraan"

                                    model: [
                                        { text: "Mobil [M]", value: "M" },
                                        { text: "Sepeda Motor [S]", value: "S" }
                                    ]
                                }
                            }

                            Row {
                                spacing: 18

                                Components.CommonTextField {
                                    id: parkingSlipNumberTextField

                                    enabled: false
                                    width: 194
                                    label: "Nomor Parking Slip"
                                }

                                Components.DropdownButton {
                                    width: 194
                                    label: "Metode Pembayaran"

                                    model: [
                                        { text: "Cash", value: 0 },
                                        { text: "Debit", value: 1 },
                                        { text: "E-Money", value: 2 }
                                    ]
                                }

                                Components.CommonTextField {
                                    width: 194
                                    label: "Kode Voucher"
                                }
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
                        text: "Cashy"
                    }

                    Components.DetailRow {
                        label: "Sistem Gerbang"
                        value: "CASUAL_POS"
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

                    Components.DetailRow {
                        label: "Unit Member"
                        value: "-"
                    }

                    Components.DetailRow {
                        id: checkInTime

                        label: "Waktu Masuk"
                        value: "-"
                    }

                    Components.DetailRow {
                        id: checkOutTime

                        label: "Waktu Keluar"
                        value: "-"
                    }

                    Components.DetailRow {
                        id: session

                        label: "Sesi"
                        value: "-"
                    }

                    Components.DetailRow {
                        label: "Diskon"
                        value: "-"
                    }

                    Components.DetailRow {
                        label: "Promo"
                        value: "-"
                    }
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 30
                    spacing: 10

                    Item {
                        width: 350
                        height: childrenRect.height

                        Components.WhiteText {
                            anchors.left: parent.left
                            text: "Total"
                            font.pixelSize: 22
                            font.bold: true
                        }

                        Components.WhiteText {
                            id: totalText

                            anchors.right: parent.right
                            font.pixelSize: 22
                            font.bold: true
                        }
                    }

                    Components.DetailRow {
                        id: duration

                        label: "Durasi"
                        value: "-"
                    }

                    Components.SubmitButton {
                        id: payButton

                        property string selectedPlateNumber

                        enabled: selectedPlateNumber
                        label: "Pay" + (totalText ? " for " + totalText.text : "")

                        onClicked: {
                            parkingDb.deleteByPlateNumber(selectedPlateNumber)
                            showSuccessDialog("Check-out success", function() {
                                navigatedBack()
                            })
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
