import 'package:flutter/material.dart';
import 'package:menuapp/screens/main_screen.dart';
import 'package:menuapp/widgets/badge.dart';
//import 'package:menuapp/screens/notifications.dart';
import 'package:menuapp/widgets/cat_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrinkScreen extends StatefulWidget {
  @override
  _DrinkScreenState createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
    String myredwine = 'redwine-list';
    String mychampagne = 'champagne-list';
    String mygins = 'gins-list';
    String myvodka = 'vodka-list';
    String mywhiskey = 'whiskey-list';
    String mywhite = 'whitewine-list';
    String myrosewine = 'rosewine-list';

  Future getmyFoodWidget(String mystring) async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('$mystring').get();
    return qn.docs;
  }
    Widget noDataFoundYet() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 5),
            Text("No Food Item available yet",
                style: TextStyle(color: Colors.black45, fontSize: 20.0)),
            Text("Please hold on...",
                style: TextStyle(color: Colors.red, fontSize: 15.0))
          ],
        ),
      ),
    );
  }

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
            Text(
              "Red Wines",
              style: TextStyle(
                fontSize: 20,
                //fontFamily: 'Vivaldii',
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            FutureBuilder(
                future:getmyFoodWidget(myredwine),
                builder:
                    ( context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }
                    if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();

                  //final documents = snapshot.data.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:  snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return CatProduct(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );
                }
                // return Text("loading");
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
            FutureBuilder(
                future:getmyFoodWidget(mychampagne),
                builder:
                    ( context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }
                    if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();

                  //final documents = snapshot.data.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:  snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return CatProduct(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );
                }
                // return Text("loading");
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
            FutureBuilder(
                future:getmyFoodWidget(mygins),
                builder:
                    ( context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }
                    if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();

                  //final documents = snapshot.data.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:  snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return CatProduct(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );
                }
                // return Text("loading");
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
            FutureBuilder(
                future:getmyFoodWidget(myvodka),
                builder:
                    ( context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }
                    if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();

                  //final documents = snapshot.data.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:  snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return CatProduct(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );
                }
                // return Text("loading");
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
            FutureBuilder(
                future:getmyFoodWidget(myvodka),
                builder:
                    ( context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }
                    if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();

                  //final documents = snapshot.data.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:  snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return CatProduct(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );
                }
                // return Text("loading");
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
            FutureBuilder(
                future:getmyFoodWidget(mywhiskey),
                builder:
                    ( context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }
                    if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();

                  //final documents = snapshot.data.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:  snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return CatProduct(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );
                }
                // return Text("loading");
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
           FutureBuilder(
                future:getmyFoodWidget(mywhiskey),
                builder:
                    ( context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }
                    if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();

                  //final documents = snapshot.data.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:  snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return CatProduct(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );
                }
                // return Text("loading");
                ),
            Text(
              "White Wine",
              style: TextStyle(
                fontSize: 20,
                //  fontFamily: 'Vivaldii',
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
           FutureBuilder(
                future:getmyFoodWidget(mywhite),
                builder:
                    ( context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }
                    if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();

                  //final documents = snapshot.data.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:  snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return CatProduct(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );
                }
                // return Text("loading");
                ),
            Text(
              "Rose Wine",
              style: TextStyle(
                fontSize: 20,
                //  fontFamily: 'Vivaldii',
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            FutureBuilder(
                future:getmyFoodWidget(myrosewine),
                builder:
                    ( context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }
                    if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();

                  //final documents = snapshot.data.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:  snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return CatProduct(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );
                }
                // return Text("loading");
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
            FutureBuilder(
                future:getmyFoodWidget(myrosewine),
                builder:
                    ( context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return noDataFoundYet();
                  }
                    if (!snapshot.hasData || snapshot.data == null)
                    return noDataFoundYet();
                  if (snapshot.data.isEmpty) return noDataFoundYet();

                  //final documents = snapshot.data.docs;
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:  snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Map food = foods[index];
                      return CatProduct(
                        img: snapshot.data[index].data()['photourl'],
                        name: snapshot.data[index].data()['name'],
                        id: snapshot.data[index].data()['id'],
                        price: snapshot.data[index].data()['price'],
                        description: snapshot.data[index].data()['description'],
                      );
                    },
                  );
                }
                // return Text("loading");
                ),
          ],
        ),
      ),
    );
  }
}
