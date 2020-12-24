import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/screens/main_screen.dart';
import 'package:menuapp/screens/walkthrough.dart';
import 'package:menuapp/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() {
    return Timer(Duration(seconds: 6), checkUser);
  }

  Future<String> _getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      prefs.setString('deviceinfo', iosDeviceInfo.toString());
      print('${iosDeviceInfo}');
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      prefs.setString('deviceinfo', androidDeviceInfo.toString());
      print('${androidDeviceInfo}');
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  void checkUser() async {
    // String name = '';
    //await _getId();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('deviceinfo');

    if (token != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
    } else {
      await _getId();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Walkthrough();
          },
        ),
      );
    }
  }

  changeScreen() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Walkthrough();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Center(
            child: Container(
                height: MediaQuery.of(context).size.height / 4.5,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/logo1.png"),
                        fit: BoxFit.fill)))),
      ),
    );
  }
}
