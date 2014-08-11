#ifndef AD_H
#define AD_H

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

#endif // AD_H
