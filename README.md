## Qt Mobile Modules ##
###Android & iOS###
___

These modules are needed to allow true univeral user interfaces. Each module must have an identical interface to QML.

**TODO**

There currently is no Android support for any of these modules. If you are interested in developing for Android, please create a pull request and we can start building a universal library of Qt mobile components.

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
	
	
* ImagePicker – [UIImagePickerController](https://developer.apple.com/library/ios/documentation/uikit/reference/UIImagePickerController_Class/UIImagePickerController/UIImagePickerController.html) support
	
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
	
* Ad - [iAd](https://developer.apple.com/library/ios/documentation/userexperience/Reference/iAd_ReferenceCollection/_index.html) view support
	
	```
	Ad {
		Component.onCompleted: display()
	}
	```
	
* Mailer - [MFMailComposeViewController](https://developer.apple.com/library/ios/documentation/MessageUI/Reference/MFMailComposeViewController_class/Reference/Reference.html) support

	```
	Mailer {
		Component.onCompleted: {
			open("Subject Line", ["recipient@gmail.com", "recipient@yahoo.com"], "Body of the email")
		}
	}
	```

	
* QML component loading to use any modal (visual) component you must expose the component as a Window
	
	```
	QQmlEngine engine;
    QQmlComponent component(&engine);
    component.loadUrl(QUrl("qrc:/main.qml"));
    QObject* comp = component.create();
    QQuickWindow* window = qobject_cast<QQuickWindow*>(comp);
    window->show();
    ```



