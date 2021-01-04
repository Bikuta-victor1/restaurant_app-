import 'package:flutter/material.dart';
//import 'package:menuapp/screens/notifications.dart';
import 'package:menuapp/widgets/cat_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('redwine-list')
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('champagne-list')
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('gins-list')
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('champagne-list')
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('vodka-list')
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('champagne-list')
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('whiskey-list')
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('whitewine-list')
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('rosewine-list')
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('whiskey-list')
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
          ],
        ),
      ),
    );
  }
}
