import 'package:flutter/material.dart';
import 'package:menuapp/models/foodmodel.dart';
//import 'package:restaurant_app/screens/notifications.dart';
import 'package:menuapp/util/foods.dart';
//import 'package:restaurant_app/widgets/badge.dart';
import 'package:menuapp/widgets/cat_product.dart';
//import 'package:restaurant_app/widgets/grid_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealScreen extends StatefulWidget {
  // final String documentId;

  // MealScreen(this.documentId);
  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  Widget build(BuildContext context) {
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
          "Meals",
          style: TextStyle(
              //  fontFamily: 'Vivaldii',
              letterSpacing: 1.4,
              fontSize: 26),
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
            Text(
              "Grills",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                //     fontFamily: 'Vivaldii',
                letterSpacing: 1.4,
              ),
              maxLines: 2,
            ),
            Divider(),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('grill-list')
                    .snapshots(),
                builder:
                    (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  final documents = snapshot.data.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return CatProduct(
                        img: documents[index].data()['photourl'],
                        name: documents[index].data()['name'],
                        id: documents[index].data()['id'],
                        price: documents[index].data()['price'],
                        description: documents[index].data()['description'],
                      );
                    },
                  );
                }
                // return Text("loading");
                ),
            SizedBox(height: 20.0),
            Text(
              "Air Fried",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                //    fontFamily: 'Vivaldii',
                letterSpacing: 1.4,
              ),
              maxLines: 2,
            ),
            Divider(),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                Map food = foods[index];
                return CatProduct(
                  img: food['img'],
                  name: food['name'],
                  //  inCart: food['inCart'],
                  // isFav: false,
                  //rating: 3
                );
              },
            ),
            SizedBox(height: 20.0),
            Text(
              "Peppered",
              style: TextStyle(
                fontSize: 20,
                //     fontFamily: 'Vivaldii',
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                Map food = foods[index];
                return CatProduct(
                  img: food['img'],
                  name: food['name'],
                  //   inCart: food['inCart'],
                  //  isFav: false,
                  //rating: 3
                );
              },
            ),
            Text(
              "Native",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Vivaldii',
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                Map food = foods[index];
                return CatProduct(
                  img: food['img'],
                  name: food['name'],
                  //inCart: food['inCart'],
                  //  isFav: false,
                  //rating: 3
                );
              },
            ),
            Text(
              "Soup",
              style: TextStyle(
                fontSize: 20,
                //     fontFamily: 'Vivaldii',
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                Map food = foods[index];
                return CatProduct(
                  img: food['img'],
                  name: food['name'],
                  //inCart: food['inCart'],
                  // isFav: false,
                  //rating: 3
                );
              },
            ),
            Text(
              "Chips",
              style: TextStyle(
                fontSize: 20,
                //   fontFamily: 'Vivaldii',
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                Map food = foods[index];
                return CatProduct(
                  img: food['img'],
                  name: food['name'],
                  //inCart: food['inCart'],
                  //  isFav: false,
                  //rating: 3
                );
              },
            ),
            Text(
              "Fries",
              style: TextStyle(
                fontSize: 20,
                //       fontFamily: 'Vivaldii',
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                Map food = foods[index];
                return CatProduct(
                  img: food['img'],
                  name: food['name'],
                  // inCart: food['inCart'],
                  // isFav: false,
                  //rating: 3
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
