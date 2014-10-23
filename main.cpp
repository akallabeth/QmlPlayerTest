#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQmlComponent>
#include <QDebug>

#include "rdpstreamplayer.h"

int main(int argc, char *argv[])
{
    const char *name = "RDPStreamPlayer";
    const char *uname = "com.thincast.RDPStreamPlayer";
    int qml = qmlRegisterType<com::thincast::RDPStreamPlayer>(uname, 1, 0, name);

    if (qml < 0) {
        qCritical() << "Could not register " << name << " in qml!";
        return -1;
    }

    QApplication app(argc, argv);

    com::thincast::RDPStreamPlayer *player = new com::thincast::RDPStreamPlayer();
    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("player", player);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
