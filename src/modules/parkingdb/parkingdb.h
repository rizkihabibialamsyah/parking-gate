#pragma once

#include <QObject>
#include <QScopedPointer>
#include <QSqlDatabase>
#include <QVariant>

class ParkingDb : public QObject
{
    Q_OBJECT
public:
    ParkingDb();

public slots:
    bool checkPlateNumberExists(const QString &plateNumber);
    void insertParkingList(const QString &vehiclePlateNumber, const QString &vehicleType, const QString &checkInTime);
    QVariantList selectByPlateNumber(const QString &plateNumber);
    void deleteByPlateNumber(const QString &plateNumber);

private:
    QSqlDatabase m_sqlDatabase;
};
