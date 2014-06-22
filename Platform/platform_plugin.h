#ifndef MODELS_PLUGIN_H
#define MODELS_PLUGIN_H

#include <QQmlExtensionPlugin>

class PlatformPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // MODELS_PLUGIN_H

