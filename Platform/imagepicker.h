#ifndef IMAGEPICKER_H
#define IMAGEPICKER_H

#include <QQuickItem>
#include "definition.h"
class ImagePicker : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString imagePath READ imagePath WRITE setImagePath NOTIFY imagePathChanged)
    Q_PROPERTY(float imageScale READ imageScale WRITE setImageScale NOTIFY imageScaleChanged)
    Q_PROPERTY(float imageQuality READ imageQuality WRITE setImageQuality NOTIFY imageQualityChanged)
    Q_PROPERTY(bool saveImageToCameraRoll READ saveImageToCameraRoll WRITE setSaveImageToCameraRoll NOTIFY saveImageToCameraRollChanged)
public:
    explicit ImagePicker(QQuickItem *parent = 0);
    Q_INVOKABLE void openPicker();
    Q_INVOKABLE void openCamera();
    QString imagePath() const
    {
        return m_imagePath;
    }

    float imageScale() const
    {
        return m_imageScale;
    }

    float imageQuality() const
    {
        return m_imageQuality;
    }

    bool saveImageToCameraRoll() const
    {
        return m_saveImageToCameraRoll;
    }

signals:
    void imagePathChanged(QString imagePath);
    void imageScaleChanged(float arg);
    void imageQualityChanged(float arg);
    void saveImageToCameraRollChanged(bool arg);

public slots:

    void setImagePath(QString arg)
    {
        if (m_imagePath != arg) {
            m_imagePath = arg;
            emit imagePathChanged(arg);
        }
    }

    void setImageScale(float arg)
    {
        if (m_imageScale != arg) {
            m_imageScale = arg;
            emit imageScaleChanged(arg);
        }
    }

    void setImageQuality(float arg)
    {
        if (m_imageQuality != arg) {
            m_imageQuality = arg;
            emit imageQualityChanged(arg);
        }
    }

    void setSaveImageToCameraRoll(bool arg)
    {
        DEBUG << arg;
        if (m_saveImageToCameraRoll != arg) {
            m_saveImageToCameraRoll = arg;
            emit saveImageToCameraRollChanged(arg);
        }
    }

private:
    void *m_delegate;
    QString m_imagePath;
    float m_imageScale;
    float m_imageQuality;
    bool m_saveImageToCameraRoll;
};

#endif // IMAGEPICKER_H
