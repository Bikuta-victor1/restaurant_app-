import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/models/foodmodel.dart';
import 'package:menuapp/util/const.dart';
import 'dart:convert' as con;
import 'package:menuapp/widgets/smooth_star_rating.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/foodmodel.dart';
import '../providers/app_provider.dart';

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

  getTotoalCount() {
    for (int i = 0; i < 1000; i++) {
      total = price * quantity;
    }
  }

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

  Future<void> checkout(List<Cart> cart, int index) async {
    // bool isSignedIn = await googleSignIn.isSignedIn();
    String token = await gettoken();
    var date = DateTime.now().toString();
    if (token != null) {
      // if so, return the current user
      print(token);
      print(cart.length);
      DocumentReference documentReference =
          FirebaseFirestore.instance.doc("Orders/${date}");
      await documentReference.get().then((datasnapshot) async {
        if (datasnapshot.exists) {
          // warning = "User already exist";
        } else {
          Map<String, String> data = <String, String>{
            "mytoken": token,
            "id": cart[index].userID,
            "ordermade": date,
            "created": cart[index].created,
            "productPrice": cart[index].productPrice,
            "itemQuantity": cart[index].itemQuantity,
            "photoUrl": cart[index].photoUrl,
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: cartlist.length != 0 && showCart
            ? ListView.builder(
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
                      cartlist.removeWhere((element) =>
                          element.created == cartlist[index].created);
                      prefs.setString('cartlist', con.json.encode(cartlist));
                      cartlist =
                          (await con.json.decode(prefs.getString('cartlist')))
                              .map<Cart>((json) => Cart.fromJson(json))
                              .toList();
                      print(cartlist.length);
                      prefs.setInt('cartlistlength', cartlist.length);
                      //AppProvider().setcartlength(cartlist.length);
                      setState(() {});
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: InkWell(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //       return ProductDetails(
                          //         id: snapshot.data.documents[index][userID],
                          //         description: description,
                          //         name: name,
                          //         img: snapshot.data.documents[index]
                          //             [photoUrl],
                          //         price: price,
                          //       );
                          //     },
                          //   ),
                          // );
                        },
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 0.0, right: 10.0),
                              child: Container(
                                height: MediaQuery.of(context).size.width / 3.5,
                                width: MediaQuery.of(context).size.width / 3,
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
                                      "N${double.parse(cartlist[index].productPrice)}",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w900,
                                        color: Theme.of(context).accentColor,
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
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : noDataFound(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Checkout",
        onPressed: () async {
          print(cartlist.length);
          int index1 = cartlist.length;
          if (cartlist.length != 0) {
            for (int i = 0; i < index1; i++) {
              await checkout(cartlist, i);
            }

            setState(() {
              showCart = false;
              cartlist = [];
            });
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
        child: Icon(
          Icons.arrow_forward,
        ),
        heroTag: Object(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
