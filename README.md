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
	
	
* ImagePicker – (custom viewer window req'd)
	
	```
	ImagePicker {
		// openPicker() - open camera roll image picker
		// openCamera() - open camera

		onImagePathChanged: {
			// The user-selected imagePath
			// Images are stored in the documents directory
			_Image.source = imagePath;
		}
		
	}
	```
	
* Ad - iAd view support
	
	```
	Ad {
		Component.onCompleted: display()
	}
	```
	
	
* QML component loading to use ImagePicker and Ad
	
	```
	QQmlEngine engine;
    QQmlComponent component(&engine);
    component.loadUrl(QUrl("qrc:/main.qml"));
    QObject* comp = component.create();
    QQuickWindow* window = qobject_cast<QQuickWindow*>(comp);
    window->show();
    ```



