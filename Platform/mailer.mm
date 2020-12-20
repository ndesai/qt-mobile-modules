#include <UIKit/UIKit.h>
#include <qpa/qplatformnativeinterface.h>
#include <QtGui>
#include <QtQuick>
#import <MessageUI/MessageUI.h>
#include "mailer.h"


@interface MailerDelegate : NSObject <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate> {
                                Mailer *m_mailer;
}
@end

@implementation MailerDelegate

- (id) initWithObject:(Mailer *)mailer
{
    self = [super init];
    if (self) {
        m_mailer = mailer;
    }
    return self;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    DEBUG;
    Q_UNUSED(controller)
    Q_UNUSED(error)
    switch (result)
    {
    case MFMailComposeResultCancelled:
        m_mailer->mailCancelled();
        break;
    case MFMailComposeResultSaved:
        m_mailer->mailSaved();
        break;
    case MFMailComposeResultSent:
        m_mailer->mailSent();
        break;
    case MFMailComposeResultFailed:
        m_mailer->mailFailed();
        break;
    default:
        m_mailer->mailCancelled();
        break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end


Mailer::Mailer(QQuickItem *parent) :
    QQuickItem(parent),
    m_delegate([[MailerDelegate alloc] initWithObject:this])
{
    DEBUG;
}

void Mailer::open(QString subject, QList<QString> recipients, QString body)
{
    UIView *view = static_cast<UIView *>(
                QGuiApplication::platformNativeInterface()
                ->nativeResourceForWindow("uiview", window()));
    UIViewController *qtController = [[view window] rootViewController];
    MFMailComposeViewController *mailer = [[[MFMailComposeViewController alloc] init] autorelease];
    [mailer setMailComposeDelegate: id(m_delegate)];
    [mailer setSubject:subject.toNSString()];
    NSMutableArray *toRecipients = [[NSMutableArray alloc] init];
    for(int i = 0; i < recipients.length(); i++)
    {
        [toRecipients addObject:recipients.at(i).toNSString()];
    }
    [mailer setToRecipients:toRecipients];
    NSString *emailBody = body.toNSString();
    [mailer setMessageBody:emailBody isHTML:NO];
    [qtController presentViewController:mailer animated:YES completion:nil];
}
