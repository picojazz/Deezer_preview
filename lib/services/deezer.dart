import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picojazz_deezer_preview/models/Album.dart';
import 'package:picojazz_deezer_preview/models/Artist.dart';
import 'package:picojazz_deezer_preview/models/Track.dart';

class Deezer {
  String api = 'https://api.deezer.com/';

  Future getChartTracks() async {
    try {
      final response = await http.get(api + "/chart");
      final jsonReponse = json.decode(response.body);
      final tracksJson = jsonReponse['tracks']['data'];
      // print(tracksJson);
      List<Track> tracks = new List();
      for (var track in tracksJson) {
        tracks.add(Track(track['artist']['name'], track['title'],
            track['preview'], track['artist']['picture_big']));
      }
      //print(tracksJson);
      return tracks;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getChartAlbum() async {
    try {
      final response = await http.get(api + "/chart");
      final jsonReponse = json.decode(response.body);
      final albumsJson = jsonReponse['albums']['data'];
      // print(tracksJson);
      List<Album> albums = new List();
      for (var album in albumsJson) {
        albums.add(Album(album['title'], album['cover_big'],
            album['artist']['name'], album['tracklist']));
      }
      print(albums[0]);
      return albums;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getTrack(album) async {
    try {
      final response = await http.get(album.listTrack);
      final jsonReponse = json.decode(response.body);
      final tracksJson = jsonReponse['data'];

      List<Track> tracks = new List();
      for (var track in tracksJson) {
        tracks.add(
            Track(album.artist, track['title'], track['preview'], album.image));
      }
      /*print(tracksJson);
      print(tracks[0].artist);
      print(tracks[0].title);
      print(tracks[0].song);
      print(tracks[0].image);*/
      return tracks;
    } catch (e) {
      print(e.toString());
    }
  }


  Future search(query) async {

      try {

      final response = await http.get(api+"search?q="+query);
      final jsonReponse = json.decode(response.body);
      final donneeJson = jsonReponse['data'];
      //print(donneeJson.toString());

      List<Track> tracks = new List();
      
      for (var track in donneeJson) {
        
          tracks.add(Track(track['artist']['name'], track['title'],
            track['preview'], track['artist']['picture_big']));
        
      }
      

      List<Album> albums = new List();
     
      for (var album in donneeJson) {
  
                  albums.add(Album(album['album']['title'], album['album']['cover_big'],
              album['artist']['name'], album['album']['tracklist']));
       
        
      }

      

      List<Artist> artists = new List();
      artists.add(Artist(donneeJson[0]['artist']['name'],donneeJson[0]['artist']['picture_big'],donneeJson[0]['artist']['tracklist']));
        

      return [tracks,albums,artists];

      } catch (e) {
        print(e.toString());
      }

  }



}
