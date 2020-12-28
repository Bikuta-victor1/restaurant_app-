import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menuapp/models/foodmodel.dart';
//import 'package:menuapp/screens/categories_screen.dart';
import 'package:menuapp/screens/dishes.dart';
import 'package:menuapp/screens/drinkscreen.dart';
import 'package:menuapp/screens/mealscreen.dart';
import 'package:menuapp/widgets/grid_product.dart';
//import 'package:menuapp/widgets/home_category.dart';
import 'package:menuapp/widgets/slider_item.dart';
import 'package:menuapp/util/foods.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  // Future<String> _getId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     // import 'dart:io'
  //     var iosDeviceInfo = await deviceInfo.iosInfo;
  //     prefs.setString('deviceinfo', iosDeviceInfo.toString());
  //     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  //   } else {
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     prefs.setString('deviceinfo', androidDeviceInfo.toString());
  //     return androidDeviceInfo.androidId; // unique ID on Android
  //   }
  // }

  // void checkFirstUser() async {
  //   //  await _getId();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('deviceinfo');
  //   if (token != null) {
  //     return null;
  //   } else {
  //     await _getId();
  //   }
  // }

  int _current = 0;
  //Future _dishdata;
  @override
  void initState() {
    // TODO: implement initState
    // checkFirstUser();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //userID = await gettoken();
    // _dishdata = getDishes();
    super.didChangeDependencies();
  }

  Future getCarouselWidget() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('grill-list').get();
    return qn.docs;
  }

  Widget noDataFound() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.find_in_page, color: Colors.black38, size: 80.0),
            Text("No Food Item available yet",
                style: TextStyle(color: Colors.black45, fontSize: 20.0)),
            Text("Please check your internet connection",
                style: TextStyle(color: Colors.red, fontSize: 15.0))
          ],
        ),
      ),
    );
  }

  Widget noDataFoundYet() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 5),
            Text("No Food Item available yet",
                style: TextStyle(color: Colors.black45, fontSize: 20.0)),
            Text("Please hold on...",
                style: TextStyle(color: Colors.red, fontSize: 15.0))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Dishes",
                  style: TextStyle(
                    letterSpacing: 1.4,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                FlatButton(
                  child: Text(
                    "View More",
                    style: TextStyle(
                      letterSpacing: 1.4,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return MealScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 10.0),
            FutureBuilder(
                future: getCarouselWidget(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }

                  if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();
                  //final documents = snapshot.data;
                  return CarouselSlider.builder(
                    autoPlay: true,
                    onPageChanged: (index) {
                      setState(() {
                        _current = index;
                      });
                    },
                    viewportFraction: 1.0,
                    itemCount:
                        //snapshot.data.length == null ? 0 :
                        snapshot.data.length,
                    height: MediaQuery.of(context).size.height / 2.4,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return SliderItem(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );

                  // items:
                  //     //map<Widget>(
                  //     documents
                  //         .map((doc) => SliderItem(
                  //               img: doc['photourl'],
                  //               name: doc['name'],
                  //               id: doc['id'],
                  //               price: doc['price'],
                  //               description: doc['description'],
                  //             ))
                  //         .toList());
//                enlargeCenterPage: true
//              aspectRatio: 2.0,
                }),
            //Slider Here
            SizedBox(height: 20.0),

            Text(
              "Food Categories",
              style: TextStyle(
                fontSize: 23,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 65.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return MealScreen();
                          },
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 0.0, right: 10.0),
                              child: Icon(
                                FontAwesomeIcons.breadSlice,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(
                                  "Meals",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    //     fontFamily: 'Vivaldii',
                                    letterSpacing: 1.4,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "7 Items",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return DrinkScreen();
                          },
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 0.0, right: 10.0),
                              child: Icon(
                                FontAwesomeIcons.wineBottle,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(
                                  "Drinks",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    //       fontFamily: 'Vivaldii',
                                    letterSpacing: 1.4,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "8 Items",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return DrinkScreen();
                          },
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 0.0, right: 10.0),
                              child: Icon(
                                FontAwesomeIcons.birthdayCake,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(
                                  "Side Dishes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    //       fontFamily: 'Vivaldii',
                                    letterSpacing: 1.4,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "2 Items",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                // itemCount: categories == null ? 0 : categories.length,
                // itemBuilder: (BuildContext context, int index) {
                //   Map cat = categories[index];
                //  return HomeCategory(
                //     icon: cat['icon'],
                //     title: cat['name'],
                //     items: cat['items'].toString(),
                //     isHome: true,
                //   );
                // },
              ),
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Popular Items",
                  style: TextStyle(
                    fontSize: 23,
                    //      fontFamily: 'Vivaldii',
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                FlatButton(
                  child: Text(
                    "View More",
                    style: TextStyle(
                      //                     fontFamily: 'Vivaldii',
                      letterSpacing: 1.4,
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 10.0),
            FutureBuilder(
                future: getCarouselWidget(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }

                  // final int dataCount =
                  //      snapshot.data.length;
                  if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:
                        snapshot.data.length == null ? 0 : snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      //Food food = Food.fromJson(foods[index]);
                      // Map food = foods[index];
                      return GridProduct(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );
                }),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
