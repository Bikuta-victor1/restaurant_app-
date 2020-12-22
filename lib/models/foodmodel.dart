import 'package:cloud_firestore/cloud_firestore.dart';
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

List<Food> cartlist = [];
List<Food> grilllist = [];
List<Food> airfriedlist = [];
List<Food> pepperedlist = [];
List<Food> nativelist = [];
List<Food> souplist = [];
List<Food> chipslist = [];
List<Food> frieslist = [];
bool addedtocart = false;
bool grills = false;


Future<List> getgrilllist( String token ) async {
  grilllist = [];
  grills = true;
  var doc = '3svndxfWUbJirgsaJJEV';
  QuerySnapshot grdocumentReference = await FirebaseFirestore.instance
      // .doc("grill-list")
      .collection("grill-list")
      .orderBy('timeupload', descending: true)
      .get();
  await grdocumentReference.docs.forEach((document) {
    Food grilllists = Food.fromMap(document.data());
    grilllist.add(grilllists);
    print(grilllist);
  });

  await grilllist.forEach((element) async {
    if (element.inCart == true) {
      cartlist.add(element);
    }
  });
  return grilllist;
}

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
