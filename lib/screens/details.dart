import 'package:flutter/material.dart';
import 'package:menuapp/models/foodmodel.dart';
import 'package:menuapp/providers/app_provider.dart';
import 'package:menuapp/screens/main_screen.dart';
import 'package:menuapp/util/const.dart';
import 'package:menuapp/widgets/badge.dart';
import 'dart:convert' as con;
import 'package:menuapp/widgets/smooth_star_rating.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/foodmodel.dart';

//final Set<dynamic> _cartsaved = Set<dynamic>();

class ProductDetails extends StatefulWidget {
  final String id;
  final String name;
  final String img;
  final String description;
  final int price;

  ProductDetails({
    Key key,
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.img,
    @required this.description,
  }) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int iquantity = 1;
  bool alreadySaved;
  int counter;
  String button = 'ADD TO CART';
  Color _color = Colors.blue;
  var date = DateTime.now().toString();

  addToCart(String id, String name, int price, int quantity, String img) async {
    await addtoCartpref(
      userid: id,
      prodtTitle: name,
      prodtPrice: price.toString(),
      itemQty: quantity.toString(),
      photUrl: img,
      date: date,
      // prodtImages: img,
    );
    // if (response == successful) {
    //   print(response);
    //   print('$quantity');
    //   alreadySaved = cartlist
    //       .contains(cartlist.where((element) => element.productTitle == name));
    //   print(alreadySaved);
    //   setState(() {
    //     if (alreadySaved) {
    //       cartlist.remove(widget.name);
    //     } else {
    //       _cartsaved.add(widget.name);
    //       print(_cartsaved);
    //     }
    //   });
    // }
  }

  // removeFromCart(
  //     String id, String name, int price, int quantity, String img) async {
  //   String response = await removefromCartpref(
  //     userid: id,
  //     prodtTitle: name,
  //     prodtPrice: price.toString(),
  //     itemQty: quantity.toString(),
  //     photUrl: img,
  //     // prodtImages: img,
  //   );
  //   // if (response == successful) {
  //   //   print(response);
  //   //   print('$quantity');
  //   //   alreadySaved = cartlist
  //   //       .contains(cartlist.where((element) => element.productTitle == name));
  //   //   print(alreadySaved);
  //   //   setState(() {
  //   //     if (alreadySaved) {
  //   //       cartlist.remove(widget.name);
  //   //     } else {
  //   //       _cartsaved.add(widget.name);
  //   //       print(_cartsaved);
  //   //     }
  //   //   });
  //   // }
  // }

  void _incrementCounter() {
    setState(() {
      iquantity++;
    });
  }

  void _decrementCounter() {
    setState(() {
      iquantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    //alreadySaved = _cartsaved.contains(widget.name);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Item Details",
        ),
        elevation: 0.0,
        actions: <Widget>[
            IconButton(
            icon:IconBadge(
                    icon: Icons.shopping_cart,
                    size: 24.0,
                  ),
            onPressed: () {
             Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MainScreen(mypage: 2,);
                  },
                ),
              );
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (BuildContext context) {
              //       return Notifications();
              //     },
              //   ),
              // );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        button == 'ADD TO CART'
                            ? Icons.shopping_cart_outlined
                            : Icons.shopping_cart,
                        color:
                            button == 'ADD TO CART' ? Colors.grey : Colors.blue,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              "${widget.name}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  SmoothStarRating(
                    starCount: 5,
                    color: Constants.ratingBG,
                    allowHalfRating: true,
                    rating: 4.0,
                    size: 10.0,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "4.0 (23 Likes)",
                    style: TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "$iquantity Pieces",
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "\u{20A6}${widget.price}",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Product Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10.0),
            Text(
              '${widget.description}',
              softWrap: true,
              maxLines: 10,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 20.0),
            Text('Quantity',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                )),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new CircleAvatar(
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => _decrementCounter(),
                  ),
                ),
                Text(
                  '$iquantity',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => _incrementCounter(),
                  ),
                ),
              ],
            ),
            // Text(
            //   "Reviews",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w800,
            //   ),
            //   maxLines: 2,
            // ),
            // SizedBox(height: 20.0),
            // ListView.builder(
            //   shrinkWrap: true,
            //   primary: false,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: comments == null ? 0 : comments.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     Map comment = comments[index];
            //     return ListTile(
            //       leading: CircleAvatar(
            //         radius: 25.0,
            //         backgroundImage: AssetImage(
            //           "${comment['img']}",
            //         ),
            //       ),
            //       title: Text("${comment['name']}"),
            //       subtitle: Column(
            //         children: <Widget>[
            //           Row(
            //             children: <Widget>[
            //               SmoothStarRating(
            //                 starCount: 5,
            //                 color: Constants.ratingBG,
            //                 allowHalfRating: true,
            //                 rating: 5.0,
            //                 size: 12.0,
            //               ),
            //               SizedBox(width: 6.0),
            //               Text(
            //                 "February 14, 2020",
            //                 style: TextStyle(
            //                   fontSize: 12,
            //                   fontWeight: FontWeight.w300,
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(height: 7.0),
            //           Text(
            //             "${comment["comment"]}",
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 50.0,
          child: RaisedButton(
            child: Text(
              button,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: _color,
            onPressed: () async {
              if (button == 'ADD TO CART') {
                setState(() {
                  button = 'ADDED TO CART';
                  _color = Colors.red;
                });
                print("$iquantity");
                SharedPreferences prefs = await SharedPreferences.getInstance();
                WidgetsFlutterBinding.ensureInitialized();
                String token = await gettoken();
                try {
                  //user = await auth.currentUser();
                  //userid = token;
                  // print(userid);
                  var item = {
                    "userID": widget.id,
                    "photoUrl": widget.img,
                    "productPrice": widget.price.toString(),
                    "created": date,
                    "itemQuantity": iquantity.toString(),
                    "productTitle": widget.name
                  };
                  Cart carted = Cart.fromMap(item);
                  cartlist.add(carted);
                   Provider.of<AppProvider>(context, listen: false)
                      .addtoTotalAmount(widget.price * iquantity); 

                  //print(cartlist.length);
                  prefs.setString('cartlist', con.json.encode(cartlist));
                  cartlist =
                      (await con.json.decode(prefs.getString('cartlist')))
                          .map<Cart>((json) => Cart.fromJson(json))
                          .toList();
                  print(cartlist.length);
                  // mycartlength = cartlist.length;
                  // prefs.setInt('cartlistlength', cartlist.length);
                  // prefs.reload();
                  // prefs.getInt('cartlistlength');
                  Provider.of<AppProvider>(context, listen: false)
                      .changeNumbertoBig();
                    
                } on Exception catch (e) {
                  return errorMSG(e.toString());
                }
                return widget.id == null ? errorMSG("Error") : successfulMSG();
                // addToCart(widget.id, widget.name, widget.price, iquantity,
                //     widget.img);
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                 Provider.of<AppProvider>(context, listen: false)
                      .subFromTotalAmount(widget.price * iquantity); 
                cartlist.removeWhere((element) =>
                    (element.productTitle == widget.name) &&
                    (element.created == date));
                //mycartlength == null ? mycartlength = 0 : mycartlength--;
                prefs.setString('cartlist', con.json.encode(cartlist));
                cartlist = (await con.json.decode(prefs.getString('cartlist')))
                    .map<Cart>((json) => Cart.fromJson(json))
                    .toList();
                print(cartlist.length);
                Provider.of<AppProvider>(context, listen: false)
                    .changeNumbertoSmall();
        
                setState(() {
                  button = 'ADD TO CART';
                  _color = Colors.blue;
                });
              }
            },
          )),
    );
  }
}
