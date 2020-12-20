#pragma once

#include <QQuickItem>

class Ad : public QQuickItem
{
    Q_OBJECT
public:
    explicit Ad(QQuickItem *parent = 0);
    Q_INVOKABLE void display();
signals:
    void loaded();

public slots:

private slots:
    void updateGeometry();

private:
    void *m_ad;
    void *m_delegate;
};
