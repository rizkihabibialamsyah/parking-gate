#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "modules/parkingdb/parkingdb.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine("qrc:/qml/main.qml");
    qmlRegisterType<ParkingDb>("Modules.ParkingDb", 1, 0, "ParkingDb");
    return app.exec();
}