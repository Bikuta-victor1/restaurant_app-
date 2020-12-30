import 'package:flutter/material.dart';
//import 'package:menuapp/screens/notifications.dart';
import 'package:menuapp/util/foods.dart';
import 'package:menuapp/widgets/cat1_product.dart';
import 'package:menuapp/widgets/cat_product.dart';

class DrinkScreen extends StatefulWidget {
  @override
  _DrinkScreenState createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
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
          "Drinks",
          style: TextStyle(
              //  fontFamily: 'Vivaldii',
              letterSpacing: 1.4,
              fontSize: 26),
        ),
        elevation: 0.0,
        actions: <Widget>[
          //   IconButton(
          //     icon: IconBadge(
          //       icon: Icons.notifications,
          //       size: 22.0,
          //     ),
          //     onPressed: () {
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (BuildContext context) {
          //             return Notifications();
          //           },
          //         ),
          //       );
          //     },
          //   ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Text(
              "Wines",
              style: TextStyle(
                fontSize: 20,
                //fontFamily: 'Vivaldii',
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
                return CatProduct1(
                  img: food['img'],
                  name: food['name'],
                  id: food['id'],
                  price: food['price'],
                  description: food['description'],
                );
              },
            ),
            SizedBox(height: 20.0),
            Text(
              "Champagne",
              style: TextStyle(
                fontSize: 20,
                //  fontFamily: 'Vivaldii',
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
                return CatProduct1(
                  img: food['img'],
                  name: food['name'],
                  id: food['id'],
                  price: food['price'],
                  description: food['description'],
                );
                ;
              },
            ),
            SizedBox(height: 20.0),
            Text(
              "Gins",
              style: TextStyle(
                fontSize: 20,
                // fontFamily: 'Vivaldii',
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
                return CatProduct1(
                  img: food['img'],
                  name: food['name'],
                  id: food['id'],
                  price: food['price'],
                  description: food['description'],
                );
                ;
              },
            ),
            Text(
              "Liquer",
              style: TextStyle(
                fontSize: 20,
                // fontFamily: 'Vivaldii',
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
                return CatProduct1(
                  img: food['img'],
                  name: food['name'],
                  id: food['id'],
                  price: food['price'],
                  description: food['description'],
                );
              },
            ),
            Text(
              "Vodka",
              style: TextStyle(
                fontSize: 20,
                //  fontFamily: 'Vivaldii',
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
                return CatProduct1(
                  img: food['img'],
                  name: food['name'],
                  id: food['id'],
                  price: food['price'],
                  description: food['description'],
                );
              },
            ),
            Text(
              "Cognac",
              style: TextStyle(
                fontSize: 20,
                //  fontFamily: 'Vivaldii',
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
                return CatProduct1(
                  img: food['img'],
                  name: food['name'],
                  id: food['id'],
                  price: food['price'],
                  description: food['description'],
                );
              },
            ),
            Text(
              "Whisky",
              style: TextStyle(
                fontSize: 20,
                //  fontFamily: 'Vivaldii',
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
                return CatProduct1(
                  img: food['img'],
                  name: food['name'],
                  id: food['id'],
                  price: food['price'],
                  description: food['description'],
                );
              },
            ),
            Text(
              "Water",
              style: TextStyle(
                fontSize: 20,
                // fontFamily: 'Vivaldii',
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
                return CatProduct1(
                  img: food['img'],
                  name: food['name'],
                  id: food['id'],
                  price: food['price'],
                  description: food['description'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
