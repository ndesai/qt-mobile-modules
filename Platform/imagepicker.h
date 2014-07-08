#ifndef IMAGEPICKER_H
#define IMAGEPICKER_H

#include <QQuickItem>
#include "definition.h"
class ImagePicker : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString imagePath READ imagePath WRITE setImagePath NOTIFY imagePathChanged)
public:
    explicit ImagePicker(QQuickItem *parent = 0);
    Q_INVOKABLE void openPicker();
    Q_INVOKABLE void openCamera();
    QString imagePath() const
    {
        return m_imagePath;
    }

signals:

    void imagePathChanged(QString imagePath);

public slots:

void setImagePath(QString arg)
{
    if (m_imagePath != arg) {
        m_imagePath = arg;
        emit imagePathChanged(arg);
    }
}

private:
void *m_delegate;
QString m_imagePath;
};

#endif // IMAGEPICKER_H
