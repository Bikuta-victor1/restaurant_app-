import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menuapp/models/foodmodel.dart';
import 'package:menuapp/screens/main_screen.dart';
import 'package:menuapp/util/const.dart';
import 'dart:convert' as con;
import 'package:menuapp/widgets/smooth_star_rating.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../models/foodmodel.dart';
import '../providers/app_provider.dart';

var tables = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
];

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin<CartScreen> {
  List<bool> inputs = List<bool>();
  bool isChecked = false;
  int carttCount;
  int index;
  int count;
  int n;
  bool showCart = true;
  double price = 0;
  double quantity = 0;
  double total = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future _data;

  List cartItems = [];

  // getTotoalCount() {
  //   for (int i = 0; i < 1000; i++) {
  //     total = price * quantity;
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    getCartCount().then((result) {
      setState(() {
        carttCount = result;
      });
    });
    super.initState();
  }

  void addquantity(int i, List<Cart> list) {
    list[i].itemQuantity = '${int.parse(list[i].itemQuantity) + 1}';
    Provider.of<AppProvider>(context, listen: false)
        .addtoTotalAmount(int.parse(list[i].productPrice));
  }

  void remmovequantity(int i, List<Cart> list) {
    if (int.parse(list[i].itemQuantity) <= 0) {
      list[i].itemQuantity = '0';

      //  list[i].itemQuantity = '${int.parse( list[i].itemQuantity) - 1}';
    } else {
      list[i].itemQuantity = '${int.parse(list[i].itemQuantity) - 1}';
      Provider.of<AppProvider>(context, listen: false)
          .subFromTotalAmount(int.parse(list[i].productPrice));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    userID = await gettoken();
    _data = getUserCart(userID);

    // for (int i = 0; i < 10000; i++) {
    //   inputs.add(true);
    //   cartItems.add(i);
    //   getTotoalCount();
    // }

    super.didChangeDependencies();
  }

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          int mynewtotalamount =
              Provider.of<AppProvider>(context, listen: true).totalamount;
          return new AlertDialog(
            content: new Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 2.6,
              decoration: new BoxDecoration(
                //shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SeatIn();
                          },
                        ),
                      );
                    },
                    child: new Container(
                      padding: new EdgeInsets.all(16.0),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.red, width: 1.0)),
                      child: new Text(
                        ' SEAT IN ',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500
                            // fontFamily: 'helvetica_neue_light',
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // dialog bottom
                  GestureDetector(
                    onTap: () async {
                      print(cartlist.length);
                      int index1 = cartlist.length;
                      for (int i = 0; i < index1; i++) {
                        await checkoutTakeOut(cartlist, i, mynewtotalamount);
                      }

                      setState(() {
                        // showCart = false;
                        Provider.of<AppProvider>(context, listen: false)
                            .setNumbertozero();
                        Provider.of<AppProvider>(context, listen: false)
                            .setTotalAmounttoZero();
                        cartlist = [];
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return TakeOut();
                          },
                        ),
                      );
                    },
                    child: new Container(
                      padding: new EdgeInsets.all(16.0),
                      decoration: new BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: new Text(
                        ' TAKE OUT ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                          //fontFamily: 'helvetica_neue_light',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> checkoutTakeOut(List<Cart> cart, int index, int total) async {
    // bool isSignedIn = await googleSignIn.isSignedIn();
    String token = await gettoken();
    var date = DateTime.now();
    String type = 'Take Out';
    if (token != null) {
      // if so, return the current user
      print(token);
      print(cart.length);
      DocumentReference documentReference =
          FirebaseFirestore.instance.doc("Orders /TakeOut Orders/ ${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}/${cart[index].itemQuantity} ${cart[index].productTitle}");
      await documentReference.get().then((datasnapshot) async {
        if (datasnapshot.exists) {
          // warning = "User already exist";
        } else {
          Map<String, String> data = <String, String>{
            "mytoken": token,
            "id": cart[index].userID,
            "ordermade": date.toString(),
            "created": cart[index].created,
            "productPrice": cart[index].productPrice,
            "itemQuantity": cart[index].itemQuantity,
            "photoUrl": cart[index].photoUrl,
            "itemname": cart[index].productTitle,
            "ordertype": type,
            "totalamount": total.toString(),
          };
          await documentReference.set(data).whenComplete(() {
            print('document added');
          }).catchError((e) {
            print(e);
            warning = e.message;
          });
        }
      });
    }
  }

  deleteCart(BuildContext context, DocumentSnapshot document, int index) async {
    deleteFromCart(document.documentID).whenComplete(() {
      // setState(() {
      // store.removeAt(index) ;
      // });
    }).whenComplete(() {
      print("success");
    });
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red[600],
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
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
            Text("Please add to your cart",
                style: TextStyle(color: Colors.red, fontSize: 15.0))
          ],
        ),
      ),
    );
  }

  //var formatter = new System.Globalization.CultureInfo("HA-LATN-NG");
  final formatCurrency = new NumberFormat.currency(symbol: " ");

  @override
  Widget build(BuildContext context) {
    int mynewtotalamount =
        Provider.of<AppProvider>(context, listen: true).totalamount;
    super.build(context);
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            cartlist.length != 0
                ? Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 2.0,
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
                                FontAwesomeIcons.moneyBill,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(
                                  "Total amount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    //       fontFamily: 'Vivaldii',
                                    letterSpacing: 1.4,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "\u20A6${formatCurrency.format(mynewtotalamount)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 5.0,
            ),
            cartlist.length != 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartlist.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background: stackBehindDismiss(),
                          key: ObjectKey(cartlist[index].created),
                          onDismissed: (direction) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            // firestore.collection('cart').document().delete();
                            //deleteCart(context, index);
                            setState(() {
                              Provider.of<AppProvider>(context, listen: false)
                                  .changeNumbertoSmall();
                              // print(int.parse(cartlist[index].productPrice));
                            });
                            print('${cartlist[index].productPrice.toString()}');
                            Provider.of<AppProvider>(context, listen: false)
                                .subFromTotalAmount(int.parse(
                                        cartlist[index].productPrice) *
                                    int.parse(cartlist[index].itemQuantity));
                            // print(
                            //     '${Provider.of<AppProvider>(context, listen: true).totalamount * 1}');
                            cartlist.removeWhere((element) =>
                                element.created == cartlist[index].created);
                            print('productPrice');
                            //print(cartlist[index].created.toString());

                            // mycartlength == null
                            //     ? mycartlength = 0
                            //     : mycartlength--;
                            prefs.setString(
                                'cartlist', con.json.encode(cartlist));

                            cartlist = (await con.json
                                    .decode(prefs.getString('cartlist')))
                                .map<Cart>((json) => Cart.fromJson(json))
                                .toList();
                            print(cartlist.length);

                            setState(() {});
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 0.0, right: 10.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.width / 3.5,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        cartlist[index].photoUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      "${cartlist[index].productTitle}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: <Widget>[
                                        SmoothStarRating(
                                          starCount: 1,
                                          color: Constants.ratingBG,
                                          allowHalfRating: true,
                                          rating: 5.0,
                                          size: 12.0,
                                        ),
                                        SizedBox(width: 6.0),
                                        Text(
                                          "4.5 ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "${int.parse(cartlist[index].itemQuantity)} Pieces",
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          "N${double.parse(cartlist[index].productPrice) * int.parse(cartlist[index].itemQuantity)}",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w900,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Quantity: ${int.parse(cartlist[index].itemQuantity)}",
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  //crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Constants.lightAccent,
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              remmovequantity(index, cartlist);
                                            });
                                            //  print(cartlist[index].itemQuantity);
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '${int.parse(cartlist[index].itemQuantity)}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Constants.lightAccent,
                                      radius: 15,
                                      child: Center(
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                addquantity(index, cartlist);
                                              });
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : noDataFound(),
            SizedBox(
              height: 20.0,
            ),
            cartlist.length != 0 && cartlist.length >= 4
                ? Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 2.0,
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
                                FontAwesomeIcons.moneyBill,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(
                                  "Total amount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    //       fontFamily: 'Vivaldii',
                                    letterSpacing: 1.4,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "\u20A6${formatCurrency.format(mynewtotalamount)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: "Checkout",
        onPressed: () async {
          print(cartlist.length);
          // int index1 = cartlist.length;
          if (cartlist.length != 0) {
            _showDialog(context);
            // for (int i = 0; i < index1; i++) {
            //   await checkout(cartlist, i);
            // }

            // setState(() {
            //   // showCart = false;
            //   Provider.of<AppProvider>(context, listen: false)
            //       .setNumbertozero();
            //   Provider.of<AppProvider>(context, listen: false)
            //       .setTotalAmounttoZero();
            //   cartlist = [];
            // });
          } else {
            Fluttertoast.showToast(
                msg: "Please Add to Cart ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Constants.darkAccent,
                textColor: Colors.white,
                fontSize: 15.0);
          }
        },
        icon: Icon(
          Icons.arrow_forward,
          size: 21,
          color: Colors.white,
        ),
        label: Text(
          ' Checkout ',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        heroTag: Object(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TakeOut extends StatefulWidget {
  @override
  _TakeOutState createState() => _TakeOutState();
}

class _TakeOutState extends State<TakeOut> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 1.8,
              child: Lottie.asset(
                'assets/cooking.json',
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                ' Please hold on, while your order is processing ',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MainScreen(
                        mypage: 0,
                      );
                    },
                  ),
                );
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width / 1.7,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ' Return to Menu',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

bool _selectTable = false;

void _toggle() {
  _selectTable = !_selectTable;
}

class SeatIn extends StatefulWidget {
  @override
  _SeatInState createState() => _SeatInState();
}

Future<void> checkoutseatin(
    List<Cart> cart, int index, String table, int total) async {
  // bool isSignedIn = await googleSignIn.isSignedIn();
  String token = await gettoken();
  var date = DateTime.now();
  if (token != null) {
    // if so, return the current user
    print(token);
    print(cart.length);
    int producttottalamount = int.parse(cart[index].itemQuantity) *
        int.parse(cart[index].productPrice);
    DocumentReference documentReference = FirebaseFirestore.instance.doc(
        "Orders /SeatOrder table $table/ ${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}/${cart[index].itemQuantity} ${cart[index].productTitle}" );
    await documentReference.get().then((datasnapshot) async {
      if (datasnapshot.exists) {
        // warning = "User already exist";
      } else {
        Map<String, String> data = <String, String>{
          "mytoken": token,
          "id": cart[index].userID,
          "ordermade": date.toString(),
          "created": cart[index].created,
          "producttotalPrice": producttottalamount.toString(),
          "itemQuantity": cart[index].itemQuantity,
          "photoUrl": cart[index].photoUrl,
          "table": table,
          "ordertype": "Seat In ",
          "itemname": cart[index].productTitle,
          "totalamountoforderMadeByUser": total.toString()
        };
        await documentReference.set(data).whenComplete(() {
          print('document added');
        }).catchError((e) {
          print(e);
          warning = e.message;
        });
      }
    });
  }
}

class _SeatInState extends State<SeatIn> {
  @override
  Widget build(BuildContext context) {
    bool _checkoutseatbool = false;
    int mynewtotalamount =
        Provider.of<AppProvider>(context, listen: true).totalamount;
    String _selectedtable =
        Provider.of<AppProvider>(context, listen: true).mytable;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                //Navigator.of(context, rootNavigator: true).pop();
                Navigator.pop(context);
              },
            ),
            title: Text("Tables"),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, childAspectRatio: 4 / 6),
                  itemCount: tables.length,
                  itemBuilder: (BuildContext context, int index) {
                    //Food food = Food.fromJson(foods[index]);
                    // Map food = foods[index];
                    return GestureDetector(
                      onTap: () {
                        // _selectTable = true;
                        //mytable = tables[index];
                        Provider.of<AppProvider>(context, listen: false)
                            .setTable(tables[index]);
                        print('mytable');

                        print(_selectedtable);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 55,
                          width: 40,
                          decoration: BoxDecoration(
                            // color: Colors.grey,
                            border: Border.all(width: 1.5, color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tables[index],
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                _selectedtable == null
                    ? Center(
                        child: Text(
                          ' Select A Table  ',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 19,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    : Text(
                        ' Selected Table : $_selectedtable  ',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 19,
                            fontWeight: FontWeight.w700),
                      ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: "Checkout",
            onPressed: () async {
              if (_selectedtable != null) {
                setState(() {
                  _checkoutseatbool = true;
                });
                //_selectedtable = null;
                print(cartlist.length);
                int index1 = cartlist.length;
                for (int i = 0; i < index1; i++) {
                  await checkoutseatin(
                      cartlist, i, _selectedtable, mynewtotalamount);
                }
                setState(() {
                  _checkoutseatbool = false;
                });

                setState(() {
                  // showCart = false;
                  Provider.of<AppProvider>(context, listen: false)
                      .setNumbertozero();
                  Provider.of<AppProvider>(context, listen: false)
                      .setTotalAmounttoZero();
                  Provider.of<AppProvider>(context, listen: false)
                      .setTable(null);
                  cartlist = [];
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return TakeOut();
                    },
                  ),
                );
              } else {
                Fluttertoast.showToast(
                    msg: "Please Select a Table",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Constants.darkAccent,
                    textColor: Colors.white,
                    fontSize: 15.0);
              }
            },
            child: _checkoutseatbool
                ? CircularProgressIndicator(backgroundColor: Colors.white)
                : Icon(
                    Icons.arrow_forward,
                    size: 21,
                    color: Colors.white,
                  ),
            heroTag: Object(),
          )),
    );
  }
}
