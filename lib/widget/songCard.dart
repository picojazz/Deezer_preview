import 'package:flutter/material.dart';
import 'package:picojazz_deezer_preview/models/Track.dart';
import 'package:picojazz_deezer_preview/player.dart';

class SongCart extends StatelessWidget {
  Track track;
  BuildContext context;
  SongCart(this.track, this.context);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.grey[850],
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AudioApp(track)));
            },
            child: ListTile(
              trailing: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              title: Text(
                track.title,
                style: TextStyle(color: Colors.grey[200], fontSize: 12.0),
              ),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(track.image)),
              subtitle: Text(
                track.artist,
                style: TextStyle(fontSize: 10.0, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
