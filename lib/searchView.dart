import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          //margin: EdgeInsets.only(top:15.0),
          child: TabBar(
            controller: controller,
            indicatorColor: Colors.grey,
            tabs: <Widget>[
              Tab(child: Text("Song",style: TextStyle(color: Colors.grey,fontFamily: "shadow",fontSize: 20.0),)),
              Tab(child: Text("Album",style: TextStyle(color: Colors.grey,fontFamily: "shadow",fontSize: 20.0),)),
              Tab(child: Text("Artist",style: TextStyle(color: Colors.grey,fontFamily: "shadow",fontSize: 20.0),)),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: <Widget>[
              SongView(),
              AlbumView(),
              ArtistView()

            ],
          ),
        )
      ],
    );
  }
}

Widget SongView(){
  return Container(
    child: Text("song"),
  );
}
Widget AlbumView(){
  return Container(
    child: Text("song2"),
  );
}
Widget ArtistView(){
  return Container(
    child: Text("song3"),
  );
}