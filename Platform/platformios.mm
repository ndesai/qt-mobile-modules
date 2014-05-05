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

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    // Create the path where we want to save the image:
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    path = [path stringByAppendingString:@"/capture.png"];

//    // Save image:
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    [UIImagePNGRepresentation(image) writeToFile:path options:NSAtomicWrite error:nil];

//    // Update imagePath property to trigger QML code:
//    m_iosCamera->m_imagePath = QStringLiteral("file:") + QString::fromNSString(path);
//    emit m_iosCamera->imagePathChanged();

//    // Bring back Qt's view controller:
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}

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

//void IOSCamera::open()
//{
//    // Get the UIView that backs our QQuickWindow:
//    UIView *view = static_cast<UIView *>(
//                QGuiApplication::platformNativeInterface()
//                ->nativeResourceForWindow("uiview", window()));
//    UIViewController *qtController = [[view window] rootViewController];

//    // Create a new image picker controller to show on top of Qt's view controller:
//    UIImagePickerController *imageController = [[[UIImagePickerController alloc] init] autorelease];
//    [imageController setSourceType:UIImagePickerControllerSourceTypeCamera];
//    [imageController setDelegate:id(m_delegate)];

//    // Tell the imagecontroller to animate on top:
//    [qtController presentViewController:imageController animated:YES completion:nil];
//}


