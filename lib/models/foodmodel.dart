import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String name;
  String photourl;
  int rating;
  bool isFav;
  bool inCart;
  String table;
  Food(
      {this.name,
      this.photourl,
      this.rating,
      this.isFav,
      this.inCart,
      this.table});

  Food.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    photourl = data['photourl'];
    rating = data['totalrating'];
    isFav = data['isFav'];
    inCart = data['inCart'];
    table = data['table'];
  }
}

List<Food> grilllist = [];
List<Food> airfriedlist = [];
List<Food> pepperedlist = [];
List<Food> nativelist = [];
List<Food> souplist = [];
List<Food> chipslist = [];
List<Food> frieslist = [];

Future<List> getfavlist() async {
  grilllist = [];
  QuerySnapshot documentReference = await FirebaseFirestore.instance
      .doc("lists")
      .collection("grill-list")
      .orderBy('timeupload', descending: true)
      .get();
  await documentReference.docs.forEach((document) {
    Food grilllists = Food.fromMap(document.data());
    grilllist.add(grilllists);
  });
  return grilllist;
}
