import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String name;
  String photourl;
  int rating;
  bool isFav;
  bool inCart;
  String tableId;
  // String table;
  Food(
      {this.name,
      this.photourl,
      this.rating,
      this.isFav,
      this.inCart,
      this.tableId
      // this.table
      });

  Food.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    photourl = data['photourl'];
    rating = data['totalrating'];
    isFav = data['isFav'];
    inCart = data['inCart'];
    tableId = data['tableId'];
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

Future<List> getgrilllist() async {
  grilllist = [];

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

// Future<DocumentSnapshot> fetchdata() async {
//   DocumentReference documentReference1 =
//       Firestore.instance.document("designers/${uid}");
//   await documentReference1.get().then((datasnapshot) async {
//     await getaccountdetailslist(uid);
//     // await getwithdrawdetailslist(uid);
//     if (datasnapshot.exists) {
//       if (status == "tailor") {
//         totalSales = datasnapshot.data["totalSales"];
//         lastloggedIn = datasnapshot.data["lastloggedIn"];
//         availableCash = datasnapshot.data["availableCash"];
//         monthlyEarned = datasnapshot.data["monthlyEarned"];
//         TotalAmount = datasnapshot.data["TotalAmount"];
//         weeklyEarned = datasnapshot.data["weeklyEarned"];
//         totalUploads = datasnapshot.data["totalUploads"];
//         totalwithdrawal = datasnapshot.data["totalwithdrawal"];
//         timeloggedin = datasnapshot.data["timeloggedin"];
//         Map<String, String> data = <String, String>{
//           "lastloggedIn":
//               "${DateTime.now().day}|${DateTime.now().month}|${DateTime.now().year}",
//           "timeloggedin":
//               "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
//         };
//         documentReference1.updateData(data).whenComplete(() {
//           print('document added');
//         }).catchError((e) {
//           print(e);
//           warning = e.message;
//         });
//         await getaccountdetailslist(uid);
//         await getwithdrawdetailslist(uid);
//         //await
//       }

//       // await getaccountdetailslist();
//     }
//   });
//   if (status == "customer") {
//     await getsearchlist();
//   }
//   print(newdesignlist.length);
//   return snapshot;
// }
