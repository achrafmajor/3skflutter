import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';
import 'package:webstreaming/Network/Api.dart';
import 'package:webstreaming/Notification/Push_Notification.dart';
import 'package:webstreaming/locator.dart';
import 'package:webstreaming/rout/rout_const.dart';

import 'package:webstreaming/variable.dart';

class Splashscreen extends StatefulWidget {
  @override

  Splashscreenstate createState() => new Splashscreenstate();

}

class Splashscreenstate extends State<Splashscreen> {
  static Map config;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final PushNotificationService _pushNotificationService =
  locator<PushNotificationService>();
  Future handleStartUpLogic() async {
    await _pushNotificationService.initialise();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleStartUpLogic();
    appstar();
  }
  Future<Null> appstar() async {
    await _fcm.subscribeToTopic('global');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    bool result = await DataConnectionChecker().hasConnection;
    String version = packageInfo.version;

    if (result == true) {
      var response = await http.get(ApimainUrl+"config");
      config = jsonDecode(response.body);

      if (config['update_statut'] == 1) {
        if (version != config['update_version']) {
          return showDialog(
              context: context, builder: (_) => _update(config['update_link']));
        }
      }
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Login_const, (Route<dynamic> route) => false);
    } else {
      print('No internet :( Reason:');
      print(DataConnectionChecker().lastTryResults);
      return showDialog(context: context, builder: (_) => _no_connexion());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'lib/images/icon.jpg',
                  width: 80,
                  height: 80,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _no_connexion() {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Icon(Icons.cloud_off, size: 70, color: Colors.white),
            Center(
                child: Text(
              'No Connexion!',
              style: TextStyle(color: Colors.white),
            )),
          ],
        ),
      ),
      /*
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
*/
    );
  }

  Widget _update(String APKurl) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Icon(Icons.system_update_alt, size: 70, color: Colors.white),
            Center(
                child: Text(
              'New Update!',
              style: TextStyle(color: Colors.white),
            )),
            Center(
              child: FlatButton(
                color: Colors.blue,
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  try {
                    //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
                    //destinationFileName is optional
                    OtaUpdate().execute(APKurl).listen(
                      (OtaEvent event) {
                        print('EVENT: ${event.status} : ${event.value}');
                      },
                    );
                  } catch (e) {
                    print('Failed to make OTA update. Details: $e');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}
