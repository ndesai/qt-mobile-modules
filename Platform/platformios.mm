#include <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#include <qpa/qplatformnativeinterface.h>
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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                          selector:@selector(applicationDidBecomeActive:)
          name:UIApplicationDidBecomeActiveNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                          selector:@selector(applicationWillResignActive:)
          name:UIApplicationWillResignActiveNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                          selector:@selector(applicationDidEnterBackground:)
          name:UIApplicationDidEnterBackgroundNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                          selector:@selector(applicationWillEnterForeground:)
          name:UIApplicationWillEnterForegroundNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                          selector:@selector(applicationDidFinishLaunching:)
          name:UIApplicationDidFinishLaunchingNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                          selector:@selector(applicationDidReceiveMemoryWarning:)
          name:UIApplicationDidReceiveMemoryWarningNotification object:nil];


        [[NSNotificationCenter defaultCenter] addObserver:self
                                                          selector:@selector(applicationWillTerminate:)
          name:UIApplicationWillTerminateNotification object:nil];

    }
    return self;
}

- (void) applicationDidBecomeActive:(id)sender
{
    DEBUG;
    m_platform->applicationDidBecomeActive();
}

- (void) applicationWillResignActive:(id)sender
{
    DEBUG;
    m_platform->applicationWillResignActive();
}

- (void) applicationDidEnterBackground:(id)sender
{
    DEBUG;
    m_platform->applicationDidEnterBackground();
}

- (void) applicationWillEnterForeground:(id)sender
{
    DEBUG;
    m_platform->applicationWillEnterForeground();
}

- (void) applicationDidFinishLaunching:(id)sender
{
    DEBUG;
    m_platform->applicationDidFinishLaunching();
}

- (void) applicationDidReceiveMemoryWarning:(id)sender
{
    DEBUG;
    m_platform->applicationDidReceiveMemoryWarning();
}

- (void) applicationWillTerminate:(id)sender
{
    DEBUG;
    m_platform->applicationWillTerminate();
}

@end

QT_BEGIN_NAMESPACE

PlatformiOS::PlatformiOS(QQuickItem *parent) :
    QQuickItem(parent),
    m_delegate([[PlatformDelegate alloc] initWithObject:this]),
    m_statusBarStyle(StatusBarStyleDefault),
    m_applicationIconBadgeNumber(0)
{
    DEBUG;
}

/**
 * @brief PlatformiOS::setStatusBarStyle
 * @param arg
 * You must set "UIViewControllerBasedStatusBarAppearance" to "NO" in your Info.plist (XCode project setup)
 */
void PlatformiOS::setStatusBarStyle(StatusBarStyle arg)
{
    qDebug() << Q_FUNC_INFO;
    if (m_statusBarStyle != arg) {
        m_statusBarStyle = arg;
        if(arg == StatusBarStyleDefault) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        } else {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
        emit statusBarStyleChanged(arg);
    }
}

/**
 * @brief PlatformiOS::setNetworkActivityIndicator
 * @param arg
 */
void PlatformiOS::setNetworkActivityIndicator(bool arg)
{
    qDebug() << Q_FUNC_INFO;
    if (m_networkActivityIndicator != arg) {
        m_networkActivityIndicator = arg;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:arg];
        emit networkActivityIndicatorChanged(arg);
    }
}

/**
 * @brief PlatformiOS::setApplicationIconBadgeNumber
 * @param arg
 */
void PlatformiOS::setApplicationIconBadgeNumber(int arg)
{
    qDebug() << Q_FUNC_INFO;
    if (m_applicationIconBadgeNumber != arg) {
        m_applicationIconBadgeNumber = arg;
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:arg];
        emit applicationIconBadgeNumberChanged(arg);
    }
}

/**
 * @brief PlatformiOS::setStatusBarVisible
 * @param arg
 */
void PlatformiOS::setStatusBarVisible(bool arg)
{
    qDebug() << Q_FUNC_INFO;
    if (m_statusBarVisible != arg) {
        m_statusBarVisible = arg;
        [[UIApplication sharedApplication] setStatusBarHidden:!arg withAnimation:UIStatusBarAnimationSlide];
        emit statusBarVisibleChanged(arg);
    }
}

/**
 * @brief PlatformiOS::vibrate
 */
void PlatformiOS::vibrate()
{
    qDebug() << Q_FUNC_INFO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

QT_END_NAMESPACE
