import 'package:flutter/material.dart';
import 'package:menuapp/models/foodmodel.dart';
import 'package:menuapp/screens/notifications.dart';
import 'package:menuapp/util/const.dart';
import 'package:menuapp/widgets/badge.dart';
import 'package:menuapp/widgets/smooth_star_rating.dart';

import '../models/foodmodel.dart';
import '../models/foodmodel.dart';

final Set<dynamic> _cartsaved = Set<dynamic>();

class ProductDetails extends StatefulWidget {
  final String id;
  final String name;
  final String img;
  //final bool inCart;
  final String description;
  final int price;
  // bool inCart;
  //final int rating;
  // final String table;

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

  addToCart(String id, String name, int price, int quantity, String img) async {
    String response = await addtoCartpref(
      userid: id,
      prodtTitle: name,
      prodtPrice: price.toString(),
      itemQty: quantity.toString(),
      photUrl: img,
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
    alreadySaved = _cartsaved.contains(widget.name);
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
          // IconButton(
          //   icon: IconBadge(
          //     icon: Icons.notifications,
          //     size: 22.0,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (BuildContext context) {
          //           return Notifications();
          //         },
          //       ),
          //     );
          //   },
          // ),
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
                        alreadySaved
                            ? Icons.shopping_cart
                            : Icons.shopping_cart_outlined,
                        color: alreadySaved ? Colors.grey : Colors.blue,
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
          child: alreadySaved
              ? RaisedButton(
                  child: Text(
                    "ADDED TO CART",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.purple,
                  onPressed: () {
                    //alreadySaved = !alreadySaved;
                    addToCart(widget.id, widget.name, widget.price, iquantity,
                        widget.img);
                  },
                )
              : RaisedButton(
                  child: Text(
                    "ADD TO CART",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    // alreadySaved = !alreadySaved;
                    //  addedtocart = !addedtocart;
                    addToCart(widget.id, widget.name, widget.price, iquantity,
                        widget.img);
                  },
                )),
    );
  }
}
