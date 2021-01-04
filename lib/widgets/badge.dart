import 'package:flutter/material.dart';
import 'package:menuapp/models/foodmodel.dart';
import 'package:menuapp/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IconBadge extends StatefulWidget {
  final IconData icon;
  final double size;

  IconBadge({Key key, @required this.icon, @required this.size})
      : super(key: key);

  @override
  _IconBadgeState createState() => _IconBadgeState();
}

// Future<int> getlength() async {

//   return prefs.getInt('cartlistlength');
// }
int mynewCartlength;

class _IconBadgeState extends State<IconBadge> {
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.reload();
    // prefs.getInt('cartlistlength') == null
    //     ? cartlength = 0
    //     : cartlength = prefs.getInt('cartlistlength');
    // print('cartlength');
    // print(cartlength);
    mynewCartlength =
        Provider.of<AppProvider>(context, listen: true).cartlength;
    super.didChangeDependencies();
  }

  // SharedPreferences prefs = await SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Icon(
          widget.icon,
          size: widget.size,
        ),
        Positioned(
          right: 0.0,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 13,
              minHeight: 13,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 1),
              child: Text(
                mynewCartlength == null ? "0" : "${mynewCartlength}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
