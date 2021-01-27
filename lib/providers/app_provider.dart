import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    checkTheme();
  }

  ThemeData theme = Constants.lightTheme;
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  int cartlength = 0;
  int totalamount = 0;
  String mytable;

  void changeNumbertoBig() {
    cartlength++;
    notifyListeners();
  }

  void changeNumbertoSmall() {
    cartlength--;
    notifyListeners();
  }

  void setNumbertozero() {
    cartlength = 0;
    notifyListeners();
  }

  void addtoTotalAmount(int addedamount) {
    totalamount = totalamount + addedamount;
    notifyListeners();
  }

  void subFromTotalAmount(int subbedamount) {
    totalamount = totalamount - subbedamount;
    notifyListeners();
  }

  void setTable(String table) {
    mytable = table;
    notifyListeners();
  }

  void setTotalAmounttoZero() {
    totalamount = 0;
    notifyListeners();
  }

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setcartlength(value) {
    cartlength = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }

  void setTheme(value, c) {
    theme = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("theme", c).then((val) {
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor:
              c == "dark" ? Constants.darkPrimary : Constants.lightPrimary,
          statusBarIconBrightness:
              c == "dark" ? Brightness.light : Brightness.dark,
        ));
      });
    });
    notifyListeners();
  }

  ThemeData getTheme(value) {
    return theme;
  }

  Future<ThemeData> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData t;
    String r =
        prefs.getString("theme") == null ? "light" : prefs.getString("theme");

    if (r == "light") {
      t = Constants.lightTheme;
      setTheme(Constants.lightTheme, "light");
    } else {
      t = Constants.darkTheme;
      setTheme(Constants.darkTheme, "dark");
    }

    return t;
  }
}
