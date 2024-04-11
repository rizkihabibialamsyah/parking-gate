import QtQuick 2.15

Item {
    property alias child: childLoader.sourceComponent

    signal navigatedTo(string url)
    signal navigatedBack()

    function showDialog(properties, onClosed) {
        dialogLoader.loadDialog(properties, onClosed)
    }

    function showSuccessDialog(text, onClosed) {
        showDialog({ title: "Success", text: text, level: AlertDialog.AlertLevel.Success }, onClosed)
    }

    function showErrorDialog(text, onClosed) {
        showDialog({ title: "Error", text: text, level: AlertDialog.AlertLevel.Error }, onClosed)
    }

    Component {
        id: alertDialog

        AlertDialog { }
    }

    Loader {
        id: childLoader

        anchors.fill: parent
        active: true
    }

    Loader {
        id: dialogLoader

        function loadDialog(properties, onClosed) {
            function onDialogLoaded() {
                for (var key in properties) {
                    dialogLoader.item[key] = properties[key]
                }

                function onDialogClosed(accepted) {
                    dialogLoader.active = false
                    dialogLoader.onLoaded.disconnect(onDialogLoaded)
                    if (onClosed != null) {
                        onClosed(accepted)
                    }
                }

                dialogLoader.item.closed.connect(onDialogClosed)
            }

            onLoaded.connect(onDialogLoaded)
            sourceComponent = alertDialog
            active = true
        }

        anchors.fill: parent
        active: false
        asynchronous: true
        visible: status == Loader.Ready
    }
}
