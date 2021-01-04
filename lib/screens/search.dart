import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/models/foodmodel.dart';
import 'package:menuapp/screens/details.dart';
import 'package:menuapp/util/const.dart';
import 'package:menuapp/widgets/smooth_star_rating.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  final TextEditingController _searchControl = new TextEditingController();
  //String name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    mydishes = await getalldishes();
    print(mydishes);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),
          Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Search..",
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                onTap: () {
                  FocusManager.instance.primaryFocus.unfocus();
                  showSearch(
                      context: context, delegate: _SearchAppBarDelegate());
                },
                // onChanged: (val) {
                //   setState(() {
                //     name = val;
                //   });
                // },
                controller: _searchControl,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "History",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            itemCount: alldishes.length,
            itemBuilder: (BuildContext context, int index) {
              // Map food = foods[index];
              return ListTile(
                title: Text(
                  "${alldishes[index].name}",
                  style: TextStyle(
//                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage(
                    alldishes[index].photourl,
                  ),
                ),
                trailing: Text("${alldishes[index].price}"),
                subtitle: Row(
                  children: <Widget>[
                    SmoothStarRating(
                      starCount: 1,
                      color: Constants.ratingBG,
                      allowHalfRating: true,
                      rating: 5.0,
                      size: 12.0,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      "${alldishes[index].totalrating}.0 (23 Reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                onTap: () {},
              );
            },
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SearchAppBarDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // return Center(
    //     query,
    //     style: TextStyle(
    //         color: Colors.blue, fontWeight: FontWeight.w900, fontSize: 30),
    //   ),
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    int getlength(final suggestions) {
      if (suggestions.length >= 5 && suggestions == searchlist) {
        return 5;
      } else {
        return suggestions.length;
      }
    }

    suggestionList = query.isEmpty
        ? alldishes
        : alldishes
            .where((element) =>
                element.name.toUpperCase().startsWith(query.toUpperCase()))
            .toList();
    return query.isNotEmpty && suggestionList.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "No Result Found",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            itemCount: getlength(suggestionList),
            itemBuilder: (BuildContext context, int index) {
              //Map food = foods[index];
              return ListTile(
                title: Text(
                  "${suggestionList[index].name}",
                  style: TextStyle(
//                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    suggestionList[index].photourl,
                  ),
                ),
                trailing: Text("${suggestionList[index].price}"),
                subtitle: Row(
                  children: <Widget>[
                    SmoothStarRating(
                      starCount: 1,
                      color: Constants.ratingBG,
                      allowHalfRating: true,
                      rating: 5.0,
                      size: 12.0,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      "${suggestionList[index].totalrating} (23 Likes)",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ProductDetails(
                          id: suggestionList[index].id.toString(),
                          description: suggestionList[index].description,
                          name: suggestionList[index].name,
                          img: suggestionList[index].photourl,
                          price: suggestionList[index].price,
                          //rating : rating;
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
  }
}
