import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanbot_sdk/common_data.dart';
import 'package:scanbot_sdk/document_scan_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_models.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';

// TODO add the Scanbot SDK license key here.
// Please note: The Scanbot SDK will run without a license key for one minute per session!
// After the trial period is over all Scanbot SDK functions as well as the UI components will stop working
// or may be terminated. You can get an unrestricted "no-strings-attached" 30 day trial license key for free.
// Please submit the trial license form (https://scanbot.io/sdk/trial.html) on our website by using
// the app identifier "com.example.myAwesomeFlutterApp" of this example app or of your app.
const SCANBOT_SDK_LICENSE_KEY = "";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    ScanbotSdk.initScanbotSdk(ScanbotSdkConfig(
      loggingEnabled: true,
      licenseKey: SCANBOT_SDK_LICENSE_KEY,
    ));

    return MaterialApp(
      title: 'Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'My Awesome Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Image currentPreviewImage;

  void scanDocument() async {
    if (!await checkLicenseStatus()) { return; }

    var config = DocumentScannerConfiguration(
      multiPageEnabled: false,
      bottomBarBackgroundColor: Colors.blueAccent,
      cancelButtonTitle: "Cancel",
      // see further configs ...
    );
    var result = await ScanbotSdkUi.startDocumentScanner(config);

    if (result.operationResult == OperationResult.SUCCESS) {
      // get and use the scanned images as pages: result.pages[n] ...
      displayPageImage(result.pages[0]);
    }
  }

  void displayPageImage(Page page) {
    setState(() {
      currentPreviewImage = Image.file(
          File.fromUri(page.documentPreviewImageFileUri), width: 300, height: 300);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              child: Text("Scan a Document"),
              onPressed: scanDocument,
            ),
            if (currentPreviewImage != null) ... [
              Text("Document image:"),
              currentPreviewImage,
            ],
            // or alternatively via short inline condition:
            // currentPreviewImage ?? Text("Image place holder"),
          ],
        ),
      ),
    );
  }

  Future<bool> checkLicenseStatus() async {
    var result = await ScanbotSdk.getLicenseStatus();
    if (result.isLicenseValid) {
      return true;
    }
    await showAlertDialog(message: 'Scanbot SDK trial period or license has expired.');
    return false;
  }

  Future<void> showAlertDialog({String title = 'Info', String message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
