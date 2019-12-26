import 'package:flutter/material.dart';
import 'package:picojazz_deezer_preview/models/Album.dart';
import 'package:picojazz_deezer_preview/models/Track.dart';
import 'package:picojazz_deezer_preview/services/deezer.dart';
import 'package:picojazz_deezer_preview/widget/songCard.dart';

class ListSongs extends StatefulWidget {
  Album album;
  List<Track> tracks = new List();
  
  ListSongs(this.album);
  @override
  _ListSongsState createState() => _ListSongsState();
}

class _ListSongsState extends State<ListSongs> {

Deezer api = Deezer();
  getTrack() async {
   dynamic result = await api.getTrack(widget.album) ;
   //print(result);
   for (var track in result) {
     widget.tracks.add(track);
     //print(widget.tracks.toString());
   }
  setState(() {
    
  });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrack();
    print(widget.album.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.album.title,style:TextStyle(color: Colors.white))
      ),
      body: ListView.builder(
                itemCount: widget.tracks.length,
                itemBuilder: (BuildContext context,int i){
                  return SongCart(widget.tracks[i],context);
                },
              ),
    );
  }
}