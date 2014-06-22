#include "platform_plugin.h"
#include "platformios.h"
#include <qqml.h>

void PlatformPlugin::registerTypes(const char *uri)
{
    // @uri st.app.models
    qmlRegisterType<PlatformiOS>(uri, 1, 0, "PlatformiOS");
}


