#include <UIKit/UIKit.h>
#include <QtGui/5.2.1/QtGui/qpa/qplatformnativeinterface.h>
#include <QtGui>
#include <QtQuick>
#include "platformios.h"

@interface PlatformDelegate : NSObject <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
                                  PlatformiOS *m_platform;
}
@end

@implementation PlatformDelegate

- (id) initWithObject:(PlatformiOS *)platform
{
    self = [super init];
    if (self) {
        m_platform = platform;
    }
    return self;
}

@end


PlatformiOS::PlatformiOS(QQuickItem *parent) :
    QQuickItem(parent),
    m_delegate([[PlatformDelegate alloc] initWithObject:this]),
    m_statusBarStyle(StatusBarStyleDefault),
    m_applicationIconBadgeNumber(0)
{
    DEBUG;
}

/*
 * setStatusBarStyle
 * You must set "UIViewControllerBasedStatusBarAppearance" to "NO" in your Info.plist (XCode project setup)
 * */
void PlatformiOS::setStatusBarStyle(StatusBarStyle arg)
{
    DEBUG << arg;
    if (m_statusBarStyle != arg) {
        m_statusBarStyle = arg;
        if(arg == StatusBarStyleDefault)
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        } else
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
        emit statusBarStyleChanged(arg);
    }
}

void PlatformiOS::setNetworkActivityIndicator(bool arg)
{
    if (m_networkActivityIndicator != arg) {
        m_networkActivityIndicator = arg;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:arg];
        emit networkActivityIndicatorChanged(arg);
    }
}

void PlatformiOS::setApplicationIconBadgeNumber(int arg)
{
    if (m_applicationIconBadgeNumber != arg) {
        m_applicationIconBadgeNumber = arg;
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:arg];
        emit applicationIconBadgeNumberChanged(arg);
    }
}

void PlatformiOS::setStatusBarVisible(bool arg)
{
    if (m_statusBarVisible != arg) {
        m_statusBarVisible = arg;
        [[UIApplication sharedApplication] setStatusBarHidden:!arg withAnimation:UIStatusBarAnimationSlide];
        emit statusBarVisibleChanged(arg);
    }
}
