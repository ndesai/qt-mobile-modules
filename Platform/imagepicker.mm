#include <UIKit/UIKit.h>
#include <QtGui/5.3.1/QtGui/qpa/qplatformnativeinterface.h>
#include <QtGui>
#include <QtQuick>
#include <MobileCoreServices/MobileCoreServices.h>
#include "imagepicker.h"
#define PICKER 6
#define CAMERA 7

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
    DEBUG << m_imagePicker->imageScale();
    DEBUG << m_imagePicker->imageQuality();
    DEBUG << m_imagePicker->saveImageToCameraRoll();
    if(picker.view.tag == CAMERA && m_imagePicker->saveImageToCameraRoll())
    {
        DEBUG << "#####" << m_imagePicker->saveImageToCameraRoll();
        UIImageWriteToSavedPhotosAlbum([info objectForKey:UIImagePickerControllerOriginalImage], nil, nil, nil);
    }
    UIImage *uImage = [UIImage imageWithCGImage:[image CGImage]
            scale:m_imagePicker->imageScale()
            orientation:UIImageOrientationDown];
    [UIImageJPEGRepresentation(uImage, m_imagePicker->imageQuality()) writeToFile:path options:NSAtomicWrite error:nil];
    m_imagePicker->setImagePath(QString::fromNSString(path));
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

ImagePicker::ImagePicker(QQuickItem *parent) :
    QQuickItem(parent),
    m_delegate([[ImagePickerDelegate alloc] initWithObject:this]),
    m_imageScale(1.0),
    m_imageQuality(1.0),
    m_saveImageToCameraRoll(false)
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
    [[imageController view] setTag:PICKER];
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
    [[imageController view] setTag:CAMERA];
    [qtController presentViewController:imageController animated:YES completion:nil];
}
