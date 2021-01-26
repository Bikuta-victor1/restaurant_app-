import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:menuapp/models/foodmodel.dart';
import 'package:menuapp/providers/app_provider.dart';
import 'package:menuapp/screens/details.dart';
import 'package:menuapp/util/const.dart';
import 'dart:convert' as con;
import 'package:menuapp/widgets/smooth_star_rating.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderItem extends StatelessWidget {
  final int id;
  final String name;
  final String img;
  //final bool isFav;
  final int price;
  final String description;

  SliderItem(
      {Key key,
      @required this.id,
      @required this.name,
      @required this.img,
      // @required this.isFav,
      @required this.price,
      @required this.description})
      : super(key: key);

  int iquantity = 1;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "$img",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                    onPressed: () async {
                      print("$iquantity");
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      WidgetsFlutterBinding.ensureInitialized();
                      var date = DateTime.now().toString();
                      String token = await gettoken();
                      try {
                        //user = await auth.currentUser();
                        //userid = token;
                        // print(userid);
                        var item = {
                          "userID": id.toString(),
                          "photoUrl": img,
                          "productPrice": price.toString(),
                          "created": date,
                          "itemQuantity": iquantity.toString(),
                          "productTitle": name
                        };
                        Cart carted = Cart.fromMap(item);
                        cartlist.add(carted);

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
                            Provider.of<AppProvider>(context, listen: false)
                            .addtoTotalAmount(price.toInt() * 1 );
                        Fluttertoast.showToast(
                            msg: "$name added to Cart ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Constants.darkAccent,
                            textColor: Colors.white,
                            fontSize: 15.0);
                      } on Exception catch (e) {
                        return errorMSG(e.toString());
                      }
                      return id == null ? errorMSG("Error") : successfulMSG();
                      // addToCart(widget.id, widget.name, widget.price, iquantity,
                      //     widget.img);
                    },
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
              child: Text(
                "$name",
                style: TextStyle(
                    fontSize: 20.0,
                    //   fontFamily: 'Vivaldii',
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4),
                maxLines: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  SmoothStarRating(
                    starCount: 5,
                    color: Constants.ratingBG,
                    allowHalfRating: true,
                    rating: 5.0,
                    size: 10.0,
                  ),
                  Text(
                    "5.0 (23 Likes)",
                    style: TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () async {
          return ProductDetails(
            id: id.toString(),
            description: description,
            name: name,
            img: img,
            price: price,
            //rating : rating;
          );
        });
  }
}
