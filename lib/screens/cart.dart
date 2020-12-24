import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/models/foodmodel.dart';
import 'package:menuapp/screens/checkout.dart';
import 'package:menuapp/util/foods.dart';
import 'package:menuapp/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin<CartScreen> {
  List<bool> inputs = List<bool>();
  bool isChecked = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future _data;
  List cartItems = [];

  getTotoalCount() {
    for (int i = 0; i < 1000; i++) {
      //  total = price * quantity;
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    userID = await gettoken();
    _data = getUserCart(userID);
    for (int i = 0; i < 10000; i++) {
      inputs.add(true);
      cartItems.add(i);
      getTotoalCount();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView.builder(
          itemCount: foods == null ? 0 : foods.length,
          itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
            Map food = foods[index];
//                print(foods);
//                print(foods.length);
            return CartItem(
              img: food['img'],
              isFav: false,
              name: food['name'],
              rating: 5.0,
              raters: 23,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Checkout",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Checkout();
              },
            ),
          );
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
