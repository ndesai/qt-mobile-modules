#ifndef PLATFORMIOS_H
#define PLATFORMIOS_H

#include <QQuickItem>
#include "definition.h"
class PlatformiOS : public QQuickItem
{
    Q_OBJECT
    Q_ENUMS(StatusBarStyle)
    Q_PROPERTY(StatusBarStyle statusBarStyle READ statusBarStyle WRITE setStatusBarStyle NOTIFY statusBarStyleChanged)
    Q_PROPERTY(bool networkActivityIndicator READ networkActivityIndicator WRITE setNetworkActivityIndicator NOTIFY networkActivityIndicatorChanged)
    Q_PROPERTY(int applicationIconBadgeNumber READ applicationIconBadgeNumber WRITE setApplicationIconBadgeNumber NOTIFY applicationIconBadgeNumberChanged)
    Q_PROPERTY(bool statusBarVisible READ statusBarVisible WRITE setStatusBarVisible NOTIFY statusBarVisibleChanged)
public:
    explicit PlatformiOS(QQuickItem *parent = 0);
    
    enum StatusBarStyle {
        StatusBarStyleDefault = 0, // Dark content, for use on light backgrounds
        StatusBarStyleLightContent = 1 // Light content, for use on dark backgrounds
    };
    
    
    StatusBarStyle statusBarStyle() const
    {
        return m_statusBarStyle;
    }

    bool networkActivityIndicator() const
    {
        return m_networkActivityIndicator;
    }

    int applicationIconBadgeNumber() const
    {
        return m_applicationIconBadgeNumber;
    }

    bool statusBarVisible() const
    {
        return m_statusBarVisible;
    }

signals:

    void statusBarStyleChanged(StatusBarStyle arg);

    void networkActivityIndicatorChanged(bool arg);

    void applicationIconBadgeNumberChanged(int arg);

    void statusBarVisibleChanged(bool arg);

public slots:

    void setStatusBarStyle(StatusBarStyle arg);

    void setNetworkActivityIndicator(bool arg);

    void setApplicationIconBadgeNumber(int arg);

    void setStatusBarVisible(bool arg);

private:
    void *m_delegate;
    StatusBarStyle m_statusBarStyle;
    bool m_networkActivityIndicator;
    int m_applicationIconBadgeNumber;
    bool m_statusBarVisible;
};

#endif // PLATFORMIOS_H
