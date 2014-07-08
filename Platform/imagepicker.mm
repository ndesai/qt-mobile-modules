#include <UIKit/UIKit.h>
#include <QtGui/5.3.0/QtGui/qpa/qplatformnativeinterface.h>
#include <QtGui>
#include <QtQuick>
#include <MobileCoreServices/MobileCoreServices.h>
#include "imagepicker.h"

@interface ImagePickerDelegate : NSObject <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
                                     ImagePicker *m_imagePicker;
}
@end

@implementation ImagePickerDelegate

- (id) initWithObject:(ImagePicker *)imagePicker
{
    self = [super init];
    if (self) {
        m_imagePicker = imagePicker;
    }
    return self;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    DEBUG;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"/image-%f.jpg", [[NSDate date] timeIntervalSince1970]];
    path = [path stringByAppendingString:fileName];
    UIImage *image = nil;
    if([info objectForKey:UIImagePickerControllerEditedImage])
    {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    else
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    UIImage *uImage = [UIImage imageWithCGImage:[image CGImage]
            scale:0.6
            orientation:UIImageOrientationDown];
    [UIImageJPEGRepresentation(uImage, 0.8) writeToFile:path options:NSAtomicWrite error:nil];
    m_imagePicker->setImagePath(QString::fromNSString(path));
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

ImagePicker::ImagePicker(QQuickItem *parent) :
    QQuickItem(parent),
    m_delegate([[ImagePickerDelegate alloc] initWithObject:this])
{
    DEBUG;
}

void ImagePicker::openPicker()
{
    UIView *view = static_cast<UIView *>(
                QGuiApplication::platformNativeInterface()
                ->nativeResourceForWindow("uiview", window()));
    UIViewController *qtController = [[view window] rootViewController];
    UIImagePickerController *imageController = [[[UIImagePickerController alloc] init] autorelease];
    [imageController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imageController setAllowsEditing: YES];
    [imageController setDelegate:id(m_delegate)];
    [imageController setMediaTypes: [NSArray arrayWithObjects:(NSString*)kUTTypeImage, nil]];
    [qtController presentViewController:imageController animated:YES completion:nil];
}

void ImagePicker::openCamera()
{
    UIView *view = static_cast<UIView *>(
                QGuiApplication::platformNativeInterface()
                ->nativeResourceForWindow("uiview", window()));
    UIViewController *qtController = [[view window] rootViewController];
    UIImagePickerController *imageController = [[[UIImagePickerController alloc] init] autorelease];
    [imageController setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imageController setAllowsEditing: YES];
    [imageController setDelegate:id(m_delegate)];
    [imageController setMediaTypes: [NSArray arrayWithObjects:(NSString*)kUTTypeImage, nil]];
    [qtController presentViewController:imageController animated:YES completion:nil];
}
