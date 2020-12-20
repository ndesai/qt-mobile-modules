#include <UIKit/UIKit.h>
#include <qpa/qplatformnativeinterface.h>
#include <QtGui>
#include <QtQuick>
#include <iAd/iAd.h>
#include "ad.h"

@interface AdDelegate : NSObject <ADBannerViewDelegate> {
    Ad *m_ad;
}
@end

@implementation AdDelegate

- (id) initWithObject:(Ad *)ad
{
    self = [super init];
    if (self) {
        m_ad = ad;
    }
    return self;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    m_ad->loaded();
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"bannerview did not receive any banner due to %@", error);
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    NSLog(@"bannerview was selected");
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return willLeave;
}


@end

Ad::Ad(QQuickItem *parent) :
    QQuickItem(parent),
    m_delegate([[AdDelegate alloc] initWithObject:this]),
    m_ad(NULL)
{
    this->setX(0);
    this->setY(0);
    this->setWidth(320);
    this->setHeight(50);
}

void Ad::display()
{
    this->updateGeometry();
}

void Ad::updateGeometry()
{
    UIView *view = static_cast<UIView *>(
                QGuiApplication::platformNativeInterface()
                ->nativeResourceForWindow("uiview", window()));

    if(m_ad)
    {
       [m_ad setFrame:CGRectMake(this->x(), this->y(), this->width(), this->height())];
    }
    else
    {
        m_ad = [[ADBannerView alloc] initWithFrame:CGRectMake(this->x(), this->y(), this->width(), this->height())];
        [m_ad setDelegate:static_cast<id>(m_delegate)];
        [view addSubview: static_cast<UIView *>(m_ad)];

        connect(this, SIGNAL(xChanged()),
                this, SLOT(updateGeometry()));
        connect(this, SIGNAL(yChanged()),
                this, SLOT(updateGeometry()));
        connect(this, SIGNAL(widthChanged()),
                this, SLOT(updateGeometry()));
        connect(this, SIGNAL(heightChanged()),
                this, SLOT(updateGeometry()));
    }
}
