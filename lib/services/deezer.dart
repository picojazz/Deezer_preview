import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picojazz_deezer_preview/models/Album.dart';
import 'package:picojazz_deezer_preview/models/Track.dart';

class Deezer {
  String api = 'https://api.deezer.com/';

  Future getChartTracks() async {
    try {
      final response = await http.get(api+"/chart");
      final jsonReponse = json.decode(response.body);
      final tracksJson = jsonReponse['tracks']['data'];
     // print(tracksJson);
      List<Track> tracks = new List();
      for(var track in tracksJson){
        tracks.add(Track(track['artist']['name'],track['title'],track['preview'],track['artist']['picture']));
      }
      //print(tracksJson);
      return tracks;

    } catch (e) {
      print(e.toString());
    }

  }

  Future getChartAlbum() async {
    try {
      final response = await http.get(api+"/chart");
      final jsonReponse = json.decode(response.body);
      final albumsJson = jsonReponse['albums']['data'];
     // print(tracksJson);
      List<Album> albums = new List();
      for(var album in albumsJson){
        albums.add(Album(album['artist']['title'],album['cover'],album['artist']['name'],album['tracklist']));
      }
      //print(tracksJson);
      return albums;

    } catch (e) {
      print(e.toString());
    }

  }

}