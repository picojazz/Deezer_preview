import 'dart:async';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:picojazz_deezer_preview/models/Track.dart';

typedef void OnError(Exception exception);



enum PlayerState { stopped, playing, paused }

class AudioApp extends StatefulWidget {
  Track track ;
  AudioApp(this.track);
  @override
  _AudioAppState createState() => new _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  
  Duration duration;
  Duration position;

  MusicFinder audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  Future initAudioPlayer() async {
    audioPlayer = new MusicFinder();
    var songs;
    try {
      songs = await MusicFinder.allSongs();
    } catch (e) {
      print(e.toString());
    }

    print(songs);
    audioPlayer.setDurationHandler((d) => setState(() {
          duration = d;
        }));

    audioPlayer.setPositionHandler((p) => setState(() {
          position = p;
        }));

    audioPlayer.setCompletionHandler(() {
      onComplete();
      setState(() {
        position = duration;
      });
    });

    audioPlayer.setErrorHandler((msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });

    setState(() {
      print(songs.toString());
    });
  }

  Future play() async {
    final result = await audioPlayer.play(widget.track.song);
    if (result == 1)
      setState(() {
        print('_AudioAppState.play... PlayerState.playing');
        playerState = PlayerState.playing;
      });
  }

 /* Future _playLocal() async {
    final result = await audioPlayer.play(localFilePath, isLocal: true);
    if (result == 1) setState(() => playerState = PlayerState.playing);
  }*/

  Future pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    final result = await audioPlayer.stop();
    if (result == 1)
      setState(() {
        playerState = PlayerState.stopped;
        position = new Duration();
      });
  }

  Future mute(bool muted) async {
    final result = await audioPlayer.mute(muted);
    if (result == 1)
      setState(() {
        isMuted = muted;
      });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
  }

//  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
//    Uint8List bytes;
//    try {
//      bytes = await readBytes(url);
//    } on ClientException {
//      rethrow;
//    }
//    return bytes;
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
          ),
          body: SafeArea(
            child: new Center(
            child: new Container(

                color: Colors.black,
                child: new Center(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          
                          width: MediaQuery.of(context).size.width/1.5,
                          height: MediaQuery.of(context).size.height/3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(widget.track.image,fit: BoxFit.fill,)),
                        ),
                        SizedBox(height: 15.0,),
                        Text(widget.track.title,style: TextStyle(
                          fontFamily: "shadow",
                          fontSize: 35.0,
                          color: Colors.white
                        ),),
                        SizedBox(height: 10.0,),
                        Text(widget.track.artist,style: TextStyle(
                          fontFamily: "Gupter",
                          fontSize: 15.0,
                          color: Colors.white
                        ),),
                        SizedBox(height: 25.0),
                        Material(child: _buildPlayer())
                       
                      ]),
                ))),
      ),
    );
  }

  Widget _buildPlayer() => new Container(
      color: Colors.black87,
      padding: new EdgeInsets.all(5.0),
      child: new Column(mainAxisSize: MainAxisSize.min, children: [
        new Row(mainAxisSize: MainAxisSize.min, children: [
          new IconButton(
              onPressed: isPlaying ? null : () => play(),
              iconSize: 40.0,
              icon: new Icon(Icons.play_arrow),
              color: Colors.orange[300]),
          new IconButton(
              onPressed: isPlaying ? () => pause() : null,
              iconSize: 40.0,
              icon: new Icon(Icons.pause),
              color: Colors.orange[300]),
          new IconButton(
              onPressed: isPlaying || isPaused ? () => stop() : null,
              iconSize: 40.0,
              icon: new Icon(Icons.stop),
              color: Colors.orange[300]),
        ]),
        duration == null
            ? new Container()
            : new Slider(
              activeColor: Colors.orange[300],
                value: position?.inMilliseconds?.toDouble() ?? 0,
                onChanged: (double value) =>
                    audioPlayer.seek((value / 1000).roundToDouble()),
                min: 0.0,
                max: duration.inMilliseconds.toDouble()),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new IconButton(
                onPressed: () => mute(true),
                icon: new Icon(Icons.headset_off),
                color: Colors.orange[300]),
            new IconButton(
                onPressed: () => mute(false),
                icon: new Icon(Icons.headset),
                color: Colors.orange[300]),
          ],
        ),
        new Row(mainAxisSize: MainAxisSize.min, children: [
          
          new Text(
              position != null
                  ? "${positionText ?? ''} / ${durationText ?? ''}"
                  : duration != null ? durationText : '',
              style: new TextStyle(fontSize: 18.0,color: Colors.white))
        ])
      ]));
}



