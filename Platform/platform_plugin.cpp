#include "platform_plugin.h"
#include "platformios.h"
#include "imagepicker.h"
#include "ad.h"
#include "mailer.h"
#include <qqml.h>

void PlatformPlugin::registerTypes(const char *uri)
{
    // @uri st.app.models
    qmlRegisterType<PlatformiOS>(uri, 1, 0, "PlatformiOS");
    qmlRegisterType<ImagePicker>(uri, 1, 0, "ImagePicker");
    qmlRegisterType<Ad>(uri, 1, 0, "Ad");
    qmlRegisterType<Mailer>(uri, 1, 0, "Mailer");
}


