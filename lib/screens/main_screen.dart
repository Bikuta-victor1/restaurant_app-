import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/models/foodmodel.dart';
import 'package:menuapp/providers/app_provider.dart';
import 'package:menuapp/screens/cart.dart';
import 'package:menuapp/screens/home.dart';
import 'package:menuapp/screens/search.dart';
import 'package:menuapp/util/const.dart';
import 'package:menuapp/widgets/badge.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final int mypage;
  // final double size;

  MainScreen({Key key, @required this.mypage}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AppProvider myappprovider;
  var currentTab = [
    Home(),
    SearchScreen(),
    CartScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
//super.initState();
      var provider = Provider.of<AppProvider>(context, listen: false);
      provider.changecurrentIndex(widget.mypage);
      // Add Your Code here.
    });

    // myappprovider.navpages = 0 ;
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies

    await addUserWithToken();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget appTitle = Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Group 8.png"), fit: BoxFit.fill)));
    var provider = Provider.of<AppProvider>(context);
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: appTitle,
          elevation: 0.0,
          actions: <Widget>[],
        ),
        body: currentTab[provider.currentIndex],
        // PageView(
        //   physics: NeverScrollableScrollPhysics(),
        //   controller: myappprovider.pageController,
        //   onPageChanged:
        //       Provider.of<AppProvider>(context, listen: false).onPageChanged,
        //   children: <Widget>[
        //     Home(),
        //     SearchScreen(),
        //     CartScreen(),
        //     //      Profile(),
        //   ],
        // ),
        bottomNavigationBar: SizedBox(
          height: 69,
          child: BottomNavigationBar(
            selectedItemColor: Constants.lightAccent,
            unselectedItemColor: Colors.grey,
            currentIndex: provider.currentIndex,
            onTap: (index) {
              setState(() {
                provider.currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: new Icon(
                    Icons.home,
                    size: 24.0,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: new Icon(
                    Icons.search,
                    size: 24.0,
                    // color: Theme.of(context).primaryColor,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: IconBadge(
                    icon: Icons.shopping_cart,
                    size: 24.0,
                  ),
                ),
                label: '',
              )
            ],
          ),
        ),
      ),
    );
  }

  // void navigationTapped(int page) {
  //   myappprovider.pageController.jumpToPage(page);
  // }

  // void onPageChanged(int page) {
  //   setState(() {
  //   //  myappprovider.navpages = page;
  //   });
  // }

}
