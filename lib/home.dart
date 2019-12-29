import 'package:flutter/material.dart';
import 'package:picojazz_deezer_preview/listSongs.dart';
import 'package:picojazz_deezer_preview/models/Album.dart';
import 'package:picojazz_deezer_preview/models/Track.dart';
import 'package:picojazz_deezer_preview/player.dart';
import 'package:picojazz_deezer_preview/search.dart';
import 'package:picojazz_deezer_preview/services/deezer.dart';
import 'package:picojazz_deezer_preview/widget/songCard.dart';



class Home extends StatefulWidget {
  List<Album> albums = new List();
  List<Track> tracks = new List();

  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

   Deezer api = Deezer();
  getTrack() async {
   dynamic result = await api.getChartTracks() ;
   //print(result);
   for (var track in result) {
     widget.tracks.add(track);
     //print(widget.tracks.toString());
   }
  
  }
  getAlbum() async {
   dynamic result = await api.getChartAlbum() ;
   for (var album in result) {
     widget.albums.add(album);
   }
   setState(() {
     
   });
   
  }
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 getAlbum();
 getTrack();
  


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Picojazz Deezer preview ",style:TextStyle(
          color: Colors.grey,
          fontFamily: "shadow",
          fontSize: 25.0,
          )),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              showSearch(context: context,delegate: Search());
            },
            icon: Icon(Icons.search,color: Colors.grey,),
          )
        ],
      ),
      //drawer: Drawer(),
      body: SafeArea(
        child: Column(
          
          children: <Widget>[
            SizedBox(height: 15.0,),
            Text("Les meilleurs albums du moment ",style: TextStyle(
              fontFamily: "shadow",
              fontSize: 20.0,
              color: Colors.grey
            ),),
            SizedBox(height: 15.0,),
            SizedBox(
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.albums.length,
                itemBuilder: (BuildContext context , int i){
                  return albumCard(widget.albums[i],context);
                },
              ),
            ),
            SizedBox(height: 15.0,),
            Text("Les songs du moment ",style: TextStyle(
              fontFamily: "shadow",
              fontSize: 20.0,
              color: Colors.grey
            ),),
            SizedBox(height: 15.0,),
            Expanded(
              child: ListView.builder(
                itemCount: widget.tracks.length,
                itemBuilder: (BuildContext context,int i){
                  return SongCart(widget.tracks[i],context);
                },
              ),
            )
          ],
        )
      ),
    );
  }
}


Widget albumCard(album,context){
  return Padding(
    padding: EdgeInsets.all(5.0),
    child: GestureDetector(
      onTap: (){
        Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListSongs(album)));
      },
          child: Container(
       
        decoration: BoxDecoration(
          //color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(album.image,fit: BoxFit.fill,))
          ],
        )
      ),
    ),
  );
}
/*
Widget songCard(track,context){
  return Container(
    
      child: Card(
      color: Colors.grey[850],
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListTile(
          trailing: GestureDetector(
            onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioApp(track)));
            },
            child: Icon(Icons.play_arrow,color: Colors.white,),
          ),
          title: Text(track.title,style: TextStyle(
            color: Colors.grey[200],
            fontSize: 12.0
          ),),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(track.image)),
            subtitle: Text(track.artist,style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey
            ),),
        ),
      ),
    ),
  );
}
*/