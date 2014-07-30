## Qt Mobile Modules ##
###Android & iOS###
___

These modules are needed to allow true univeral user interfaces. Each module must have an identical interface to QML.

**Modules**

* Platform (iOS-specific)
	* setStatusBarStyle
	* networkActivityIndicator
	* applicationIconBadgeNumber
	* application lifecycle notifications / signals
		* applicationDidBecomeActive
		* applicationWillResignActive
		* applicationDidEnterBackground
		* applicationWillEnterForeground
		* applicationDidFinishLaunching
		* applicationDidReceiveMemoryWarning
		* applicationWillTerminate
	* vibrate
	* image picker – custom viewer window required:
	
	```
	QQmlEngine engine;
    QQmlComponent component(&engine);
    component.loadUrl(QUrl("qrc:/main.qml"));
    QObject* comp = component.create();
    QQuickWindow* window = qobject_cast<QQuickWindow*>(comp);
    window->show();
    ```



