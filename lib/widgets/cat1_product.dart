import 'package:flutter/material.dart';
import 'package:menuapp/screens/details.dart';
import 'package:menuapp/util/const.dart';
import 'package:menuapp/widgets/smooth_star_rating.dart';

class CatProduct1 extends StatelessWidget {
  final String name;
  final String img;
  final String id;
  final int price;
  final String description;

  CatProduct1({
    Key key,
    @required this.name,
    @required this.img,
    @required this.id,
    @required this.price,
    //  @required this.inCart,
    //  @required this.isFav,
    //  @required this.rating,
    @required this.description,
    //  @required this.table,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.9,
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        "$img",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   right: -10.0,
                  //   bottom: 3.0,
                  //   child: RawMaterialButton(
                  //     onPressed: () async {
                  //       SharedPreferences prefs =
                  //           await SharedPreferences.getInstance();
                  //       var token = prefs.getString('deviceinfo');
                  //       var timenow = DateTime.now().toString();
                  //       if (addedtocart = true) {
                  //         DocumentReference documentReference = await Firestore
                  //             .instance
                  //             .document("tables/$token")
                  //             .collection("orders")
                  //             .doc("${grills?timenow:null}");
                  //       }
                  //     },
                  //     fillColor: Colors.white,
                  //     shape: CircleBorder(),
                  //     elevation: 4.0,
                  //     child: Padding(
                  //       padding: EdgeInsets.all(5),
                  //       child: Icon(
                  //         addedtocart
                  //             ? Icons.shopping_cart
                  //             : Icons.shopping_cart_outlined,
                  //         color: Colors.red,
                  //         size: 17,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
                child: Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 20.0,
                    //    fontFamily: 'Vivaldii',
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        SmoothStarRating(
                          starCount: 5,
                          color: Constants.ratingBG,
                          allowHalfRating: true,
                          rating: 4.0,
                          size: 13.0,
                        ),
                        Text(
                          "4.0",
                          style: TextStyle(
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 3.0),
                    Text(
                      "\u{20A6} $price",
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProductDetails(
                    id: id.toString(),
                    description: description,
                    name: name,
                    img: img,
                    price: price,
                    //rating : rating;
                  );
                },
              ),
            );
          }),
    );
  }
}
