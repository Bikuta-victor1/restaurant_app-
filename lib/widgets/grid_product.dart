import 'package:flutter/material.dart';
// import 'package:menuapp/screens/details.dart';
// import 'package:menuapp/util/const.dart';
// import 'package:menuapp/widgets/smooth_star_rating.dart';

class GridProduct extends StatelessWidget {
  final String name;
  final String img;
  final String route;

  GridProduct(
      {Key key, @required this.name, @required this.img, @required this.route})
      : super(key: key);

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
                height: MediaQuery.of(context).size.height / 3.9,
                width: MediaQuery.of(context).size.width / 2.2,
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
              //     onPressed: () {},
              //     fillColor: Colors.white,
              //     shape: CircleBorder(),
              //     elevation: 4.0,
              //     child: Padding(
              //       padding: EdgeInsets.all(5),
              //       child: Icon(
              //         isFav ? Icons.favorite : Icons.favorite_border,
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
           //     fontFamily: 'Vivaldii',
                letterSpacing: 1.4,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
          //   child: Row(
          //     children: <Widget>[
          //       SmoothStarRating(
          //         starCount: 5,
          //         color: Constants.ratingBG,
          //         allowHalfRating: true,
          //         rating: rating,
          //         size: 10.0,
          //       ),
          //       Text(
          //         " $rating ($raters Reviews)",
          //         style: TextStyle(
          //           fontSize: 11.0,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, "$route");
      },
    );
  }
}
