import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as con;
import 'package:shared_preferences/shared_preferences.dart';

class Food {
  String name;
  String photourl;
  int rating;
  bool isFav;
  bool inCart;
  //String tableId;
  // String table;
  Food({
    this.name,
    this.photourl,
    this.rating,
    this.isFav,
    this.inCart,
    //  this.tableId
    // this.table
  });

  Food.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    photourl = data['photourl'];
    rating = data['totalrating'];
    isFav = data['isFav'];
    inCart = data['inCart'];
    // tableId = data['tableId'];
    // table = data['table'];
  }
}

class Cart {
  String userID;
  String created;
  String productTitle;
  String productPrice;
  String itemQuantity;
  String photoUrl;
  //String tableId;
  // String table;
  Cart({
    this.created,
    this.itemQuantity,
    this.photoUrl,
    this.productPrice,
    this.productTitle,
    this.userID,
    // this.table
  });
  Map<String, dynamic> toJson() => {
        'userID': userID,
        'photoUrl': photoUrl,
        'productPrice': productPrice,
        'itemQuantity': itemQuantity,
        'productTitle': productTitle,
        'created': created,
      };
  Cart.fromJson(Map<String, dynamic> data) {
    userID = data['userID'];
    photoUrl = data['photoUrl'];
    productPrice = data['productPrice'];
    created = data['created'];
    itemQuantity = data['itemQuantity'];
    productTitle = data['productTitle'];
    // table = data['table'];
  }

  Cart.fromMap(Map<String, dynamic> data) {
    userID = data['userID'];
    photoUrl = data['photoUrl'];
    productPrice = data['productPrice'];
    created = data['created'];
    itemQuantity = data['itemQuantity'];
    productTitle = data['productTitle'];
    // table = data['table'];
  }
}

List<Cart> cartlist = [];
List<Food> grilllist = [];
List<Food> airfriedlist = [];
List<Food> pepperedlist = [];
List<Food> nativelist = [];
List<Food> souplist = [];
List<Food> chipslist = [];
List<Food> frieslist = [];
bool addedtocart = false;
// bool isGrills = false;
// bool isAirFried = false;
// bool isPeppered = false;
// bool isNative = false;
// bool isSoup = false;
// bool isChips = false;
String userID;
String created;
String productTitle;
String productPrice;
String itemQuantity;
String photoUrl;
String successful = 'Successful';

FirebaseFirestore firestore = FirebaseFirestore.instance;

// Future<List> getairfriedlist( String token ) async {
//     airfriedlist = [];
//     QuerySnapshot grdocumentReference = await FirebaseFirestore.instance
//         // .doc("grill-list")
//         .collection("air-fried-list")
//         .orderBy('timeupload', descending: true)
//         .get();
//     await grdocumentReference.docs.forEach((document) {
//       Food airfriedlists = Food.fromMap(document.data());
//       airfriedlist.add(airfriedlists);
//       print(airfriedlist);
//     });

//     await airfriedlist.forEach((element) async {
//       if (element.inCart == true) {
//         cartlist.add(element);
//       }
//     });
//     return airfriedlist;
//   }

Future<String> gettoken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var mytoken = prefs.getString('deviceinfo');
  return mytoken;
}

String warning;

Future<void> addUserWithToken() async {
  // bool isSignedIn = await googleSignIn.isSignedIn();
  String token = await gettoken();
  if (token != null) {
    // if so, return the current user
    print(token);
    DocumentReference documentReference =
        FirebaseFirestore.instance.doc("Users/${token}");
    await documentReference.get().then((datasnapshot) async {
      if (datasnapshot.exists) {
        // warning = "User already exist";
      } else {
        Map<String, String> data = <String, String>{
          "mytoken": token,
        };
        await documentReference.set(data).whenComplete(() {
          print('document added');
        }).catchError((e) {
          print(e);
          warning = e.message;
        });
      }
    });
  }
}

Future<String> successfulMSG() async {
  return 'successful';
}

Future<String> errorMSG(String e) async {
  return e;
}

@override
Future<String> addtoCart(
    {String userid,
    String prodtTitle,
    //  String prodtVariation,
    String prodtPrice,
    String itemQty,
    String date,
    String photUrl}) async {
  //FirebaseUser user;
  String token = await gettoken();
  try {
    //user = await auth.currentUser();
    //userid = token;
    var date = DateTime.now().toString();
    // print(userid);

    if (userid != null) {
      await firestore.collection('cart').add({
        userID: userid,
        productTitle: prodtTitle,
        //  productVariation: prodtVariation,
        productPrice: prodtPrice,
        itemQuantity: itemQty,
        photoUrl: photUrl,
        created: date,
      });
      print(userid);
      print('document added');
    }
  } on Exception catch (e) {
    return errorMSG(e.toString());
  }
  return userid == null ? errorMSG("Error") : successfulMSG();
}

@override
Future<String> addtoCartpref(
    {String userid,
    String prodtTitle,
    //  String prodtVariation,
    String prodtPrice,
    String itemQty,
    String date,
    String photUrl}) async {
  print("$itemQty");
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //FirebaseUser user;
  String token = await gettoken();
  try {
    //user = await auth.currentUser();
    //userid = token;
    var date = DateTime.now().toString();
    // print(userid);
    var item = {
      "userID": userid,
      "photoUrl": photUrl,
      "productPrice": prodtPrice,
      "created": date,
      "itemQuantity": itemQty,
      "productTitle": prodtTitle
    };
    Cart carted = Cart.fromMap(item);
    cartlist.add(carted);
    //print(cartlist.length);
    prefs.setString('cartlist', con.json.encode(cartlist));
    cartlist = (await con.json.decode(prefs.getString('cartlist')))
        .map<Cart>((json) => Cart.fromJson(json))
        .toList();
    print(cartlist.length);

    // if (userid != null) {
    //   await firestore.collection('cart').add({
    //     userID: userid,
    //     productTitle: prodtTitle,
    //     //  productVariation: prodtVariation,
    //     productPrice: prodtPrice,
    //     itemQuantity: itemQty,
    //     photoUrl: photUrl,
    //     created: date,
    //   });
    //   print(userid);
    //   print('document added');
    // }
  } on Exception catch (e) {
    return errorMSG(e.toString());
  }
  return userid == null ? errorMSG("Error") : successfulMSG();
}

@override
Future deleteFromCart(String docID) async {
  Future result = await firestore
      .collection('cart')
      .doc(docID)
      .delete()
      .then((msg) {})
      .catchError((e) {
    print(e);
  });

  return result;
}

// @override
// Future searchByName(String searchField) {
//   return firestore
//       .collection(appProducts)
//       .where(searchKey, isEqualTo: searchField.substring(0, 1).toUpperCase())
//       .get();
// }

// List<DocumentSnapshot> documentList = (await Firestore.instance
//         .collection("cases")
//         .document(await firestoreProvider.getUid())
//         .collection(caseCategory)
//         .where("caseNumber", arrayContains: query)
//         .getDocuments())
//     .documents;

@override
Future getUserCart(String userid) async {
  // final FirebaseUser user = await auth.currentUser();
  String token = await gettoken();
  final uid = token;

  //userId = userID;
  if (token != null) {
    CollectionReference col = firestore.collection('cart');
    Query nameQuery = col.where("userID", isEqualTo: uid);
    return nameQuery.get();
  }
}

@override
getCartCount() async {
  // final FirebaseUser user = await auth.currentUser();
  String token = await gettoken();
  List<DocumentSnapshot> _myDocCount = [];
  if (token != null && _myDocCount != null) {
    //final uid = user.uid;
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection('cart')
        .where("userID", isEqualTo: token)
        .get();
    _myDocCount = _myDoc.docs;
    print(_myDocCount.length);
  }
  return _myDocCount.length;
}

Future getCart() async {
  // FirebaseUser user;
  String userid;
  QuerySnapshot qn;
  String token = await gettoken();
  //user = await auth.currentUser();
  try {
    userid = token;

    qn = await firestore.collection("cart").get();
  } on PlatformException catch (e) {
    print(e.message);
  }
  return qn.docs;
}

Future getDishes() async {
  // FirebaseUser user;
  String userid;
  QuerySnapshot qn;
  String token = await gettoken();
  //user = await auth.currentUser();
  try {
    userid = token;

    qn = await firestore.collection("grill-list").get();
  } on PlatformException catch (e) {
    print(e.message);
  }
  return qn.docs;
}

//  Future<String> userCart({String userid,String prodtTitle,String prodtVariation,String prodtPrice,String itemQty, List prodtImages});
//    Future getCurrentUser(String userid);
//    Future getCart();
// Future getCart();
