#include "parkingdb.h"

#include <QStandardPaths>
#include <QSqlQuery>
#include <QSqlRecord>

#define QUERY_CREATE "CREATE TABLE IF NOT EXISTS ParkingList (VehiclePlateNumber TEXT, VehicleType TEXT, CheckInTime TEXT)"
#define QUERY_SELECT "SELECT rowid,* FROM ParkingList WHERE VehiclePlateNumber = '%1'"
#define QUERY_INSERT "INSERT INTO ParkingList VALUES (?, ?, ?)"
#define QUERY_DELETE "DELETE FROM ParkingList WHERE VehiclePlateNumber = '%1'"

ParkingDb::ParkingDb()
{
    m_sqlDatabase = QSqlDatabase::addDatabase("QSQLITE");

    QString dbPath = QStandardPaths::writableLocation(QStandardPaths::DataLocation) + "/parking.db";
    m_sqlDatabase.setDatabaseName(dbPath);

    if (m_sqlDatabase.open()) {
        QSqlQuery query;
        query.exec(QUERY_CREATE);
    }
}

bool ParkingDb::checkPlateNumberExists(const QString &plateNumber)
{
    QSqlQuery query;
    query.prepare(QString(QUERY_SELECT).arg(plateNumber));

    if (query.exec()) {
        if (query.next())
            return true;
    }

    return false;
}

void ParkingDb::insertParkingList(const QString &vehiclePlateNumber, const QString &vehicleType, const QString &checkInTime)
{
    QSqlQuery query;
    query.prepare(QUERY_INSERT);
    query.addBindValue(QVariant(vehiclePlateNumber));
    query.addBindValue(QVariant(vehicleType));
    query.addBindValue(QVariant(checkInTime));
    query.exec();
}

QVariantList ParkingDb::selectByPlateNumber(const QString &plateNumber)
{
    QSqlQuery query;
    query.prepare(QString(QUERY_SELECT).arg(plateNumber));
    QVariantList tempList;

    if (query.exec()) {
        while (query.next()) {
            for (int i = 0; i < query.record().count(); ++i) {
                tempList.push_back(query.value(i));
            }
        }
    }

    return tempList;
}

void ParkingDb::deleteByPlateNumber(const QString &plateNumber)
{
    QSqlQuery query;
    query.prepare(QString(QUERY_DELETE).arg(plateNumber));
    query.exec();
}
