#ifndef MAILER_H
#define MAILER_H

#include <QQuickItem>
#include "definition.h"

class Mailer : public QQuickItem
{
    Q_OBJECT
public:
    explicit Mailer(QQuickItem *parent = 0);
    Q_INVOKABLE void open(QString subject, QList<QString> toRecipients, QString body);
signals:
    void mailCancelled();
    void mailSaved();
    void mailSent();
    void mailFailed();

public slots:

private:
    void *m_delegate;

};

#endif // MAILER_H
