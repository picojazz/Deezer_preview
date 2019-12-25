import 'package:flutter/material.dart';
import 'package:picojazz_deezer_preview/models/Album.dart';
import 'package:picojazz_deezer_preview/models/Track.dart';
import 'package:picojazz_deezer_preview/services/deezer.dart';



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
     print(widget.tracks.toString());
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
      body: SafeArea(
        child: Column(
          
          children: <Widget>[
            TextField(
              
            ),
            Text("Les meilleurs albums du moment ",style: TextStyle(
              fontFamily: "shadow",
              fontSize: 20.0,
              color: Colors.grey
            ),),
            SizedBox(height: 15.0,),
            Expanded(

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.albums.length,
                itemBuilder: (BuildContext context , int i){
                  return albumCard(widget.albums[i]);
                },
              ),
            ),
            //SizedBox(height: 15.0,),
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
                  return songCard(widget.tracks[i]);
                },
              ),
            )
          ],
        )
      ),
    );
  }
}


Widget albumCard(album){
  return Padding(
    padding: EdgeInsets.all(5.0),
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
  );
}

Widget songCard(track){
  return Card(
    elevation: 10.0,
    child: ListTile(
      title: Text(track.title,style: TextStyle(
        color: Colors.grey
      ),),
      leading: Image.network(track.image),
    ),
  );
}