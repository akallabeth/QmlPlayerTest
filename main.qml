import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtMultimedia 5.0
import com.thincast.RDPStreamPlayer 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    FileDialog {
        id: openFile
        title: qsTr("Open File")
        selectMultiple: false
        nameFilters: [qsTr("Video files (*.mkv *.avi *.mp4 *.mpeg *.webm *.3gp *.mov *.ogv *.wmv)"),
            qsTr("Audio files (*.ogg *.flac *.mp3 *.aac *.wma)"),
            qsTr("All files(*)")]

        onAccepted: {
            console.log("Accepted file " + openFile.fileUrl)
            actionStartPlayback.enabled = true
            actionTogglePlayback.enabled = true
        }
        onRejected: {
            console.log("Rejected file " + openFile.fileUrl)
            actionTogglePlayback.enabled = false
            actionStartPlayback.enabled = false
            actionPausePlayback.enabled = false
            actionStopPlayback.enabled = false
        }
    }

    Action {
        id: actionTogglePlayback
        text: qsTr("&Toggle")
        shortcut: "Ctrl+T"
        enabled: false
        onTriggered: {
            console.log("Toggle action triggered")
            if (actionPausePlayback.enabled) {
                actionStartPlayback
            } else {
                actionPausePlayback
            }
        }
    }
    Action {
        id: actionStartPlayback
        text: qsTr("&Play")
        shortcut: "Ctrl+R"
        enabled: false
        onTriggered: {
                    console.log("Play action triggered");
                    player.play()
                    actionStartPlayback.enabled = false
                    actionOpenFile.enabled = false
                    actionPausePlayback.enabled = true
                    actionStopPlayback.enabled = true
        }

        tooltip: qsTr("Start playback of file ") + openFile.fileUrl
    }
    Action {
        id: actionPausePlayback
        text: qsTr("&Pause")
        shortcut: "Ctrl+P"
        enabled: false
        onTriggered: {
                    console.log("Pause action triggered");
                    player.pause()
                    actionStartPlayback.enabled = true
                    actionPausePlayback.enabled = false
        }

        tooltip: qsTr("Pause playback of file ") + openFile.fileUrl
    }
    Action {
        id: actionStopPlayback
        text: qsTr("&Stop")
        shortcut: "Ctrl+S"
        enabled: false
        onTriggered: {
                    console.log("Stop action triggered");
                    player.stop()
                    actionStartPlayback.enabled = true
                    actionStopPlayback.enabled = false
                    actionPausePlayback.enabled = false
                    actionOpenFile.enabled = true
        }

        tooltip: qsTr("Stop playback of file ") + openFile.fileUrl
    }
    Action {
        id: actionOpenFile
        text: qsTr("&Open")
        shortcut: "Ctrl+O"
        onTriggered: {
            console.log("Open file action triggered")
            openFile.open()
        }
        tooltip: qsTr("Open a new file")
    }
    Action {
        id: actionAbout
        text: qsTr("&About")
        shortcut: "Ctrl+A"
        onTriggered: aboutDialog.open()
    }
    Action {
        id: actionQuit
                text: qsTr("Exit")
        shortcut: "Ctrl+Q"
                onTriggered: Qt.quit();
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem { action: actionOpenFile }
            MenuSeparator { }
            MenuItem { action: actionStartPlayback }
            MenuItem { action: actionPausePlayback }
            MenuItem { action: actionStopPlayback }
            MenuSeparator { }
            MenuItem { action: actionQuit }
        }
        Menu {
            title: qsTr("&Help")
            MenuItem { action: actionAbout }
        }
    }

    MediaPlayer {
        id: player1
        source: openFile.fileUrl
    }

    RDPStreamPlayer {
        id: player
        source: openFile.fileUrl
    }

    VideoOutput {
        id: videoOutput
        source: player
        anchors.fill: parent
    }

    MouseArea {
        id: playArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onPressed: actionTogglePlayback
    }
}
