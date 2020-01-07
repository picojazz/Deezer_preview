import 'package:flutter/material.dart';
import 'package:picojazz_deezer_preview/listSongs.dart';
import 'package:picojazz_deezer_preview/models/Album.dart';
import 'package:picojazz_deezer_preview/models/Artist.dart';
import 'package:picojazz_deezer_preview/models/Track.dart';
import 'package:picojazz_deezer_preview/services/deezer.dart';
import 'package:picojazz_deezer_preview/widget/songCard.dart';

class SearchView extends StatefulWidget {
  List<Album> albums = new List();
  List<Track> tracks = new List();

  String query;
  SearchView(this.query);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  TabController controller;

  Deezer api = Deezer();
  getSearch() async {
    dynamic result = await api.search(widget.query);
    print('search result');
    widget.tracks = result[0];
    widget.albums = result[1];

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(vsync: this, length: 2);
    getSearch();
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
              Tab(
                  child: Text(
                "Song",
                style: TextStyle(
                    color: Colors.grey, fontFamily: "shadow", fontSize: 20.0),
              )),
              Tab(
                  child: Text(
                "Album",
                style: TextStyle(
                    color: Colors.grey, fontFamily: "shadow", fontSize: 20.0),
              )),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: <Widget>[
              SongView(widget.tracks),
              AlbumView(widget.albums)
            ],
          ),
        )
      ],
    );
  }
}

Widget SongView(tracks) {
  return ListView.builder(
    itemCount: tracks.length,
    itemBuilder: (BuildContext context, int i) {
      return SongCart(tracks[i], context);
    },
  );
}

Widget AlbumView(albums) {
  return ListView.builder(
    itemCount: albums.length,
    itemBuilder: (BuildContext context, int i) {
      return Container(
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListSongs(albums[i])));
            },
            child: Card(
              color: Colors.grey[850],
              elevation: 10.0,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  title: Text(
                    albums[i].title,
                    style: TextStyle(color: Colors.grey[200], fontSize: 12.0),
                  ),
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(albums[i].image)),
                  subtitle: Text(
                    albums[i].artist,
                    style: TextStyle(fontSize: 10.0, color: Colors.grey),
                  ),
                ),
              ),
            )),
      );
    },
  );
}
