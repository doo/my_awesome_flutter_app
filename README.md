# My Awesome Flutter App

A simple Flutter demo app based on the tutorial in the blog post 
["Integrating the Scanbot SDK in a Flutter App"](TODO:LINK).

For a **full** example project which demonstrates **all** API methods of the Scanbot SDK Flutter Plugin
see the repo [scanbot-sdk-example-flutter](https://github.com/doo/scanbot-sdk-example-flutter).

## How to run this app

Install [Flutter](https://flutter.dev) and all required dev tools.
 
Fetch this repository and navigate to the project directory.

```
cd my_awesome_flutter_app/
```

Fetch and install the dependencies of this example project via Flutter CLI:

```
flutter pub get
```

Connect a mobile device via USB and run the app.

**Android:**

```
flutter run -d <DEVICE_ID>
```

You can get the IDs of all connected devices via `flutter devices`.

**iOS:**

Install Pods dependencies:

```
cd ios/
pod install
```

Open the **workspace**(!) `ios/Runner.xcworkspace` in Xcode and adjust the *Signing / Developer Account* settings. 
Then build and run the app in Xcode.
