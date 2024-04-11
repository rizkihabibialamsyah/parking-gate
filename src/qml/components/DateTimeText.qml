import QtQuick 2.15

WhiteText {
    id: dateTimeText

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            dateTimeText.text = Qt.formatDateTime(new Date(), "dd MMM yyyy hh:mm:ss")
        }
    }
}
