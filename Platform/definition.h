#pragma once

#include <QDateTime>
#define DEBUG if(1) qDebug() << QDateTime::currentDateTime().toString("dd/MM/yyyy hh:mm:ss:zzz") <<  __PRETTY_FUNCTION__
