import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';
import 'widgets/background.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RadioPlayerScreen(),
    );
  }
}

class RadioPlayerScreen extends StatefulWidget {
  const RadioPlayerScreen({super.key});
  @override
  _RadioPlayerScreenState createState() => _RadioPlayerScreenState();
}

class _RadioPlayerScreenState extends State<RadioPlayerScreen> {
  final RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  String _songTitle = "";
  String _artist = "";

  @override
  void initState() {
    super.initState();
    _radioPlayer.setChannel(
      title: _songTitle,
      url: "https://stream.radiotechnikum.at:80/YURADIO",
    );
    _radioPlayer.metadataStream.listen((metadata) async {
      setState(() {
        _artist = metadata[0];
        _songTitle = metadata[1];
      });
    });
  }

  void _togglePlayPause() {
    if (isPlaying) {
      _radioPlayer.stop();
    } else {
      _radioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Positioned(child: BackgroundScreen()),
              Positioned.fill(
                  left: 0,
                  child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 62, bottom: 10),
                              child: Container(
                                height: 100,
                                width: 100,
                                child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        Colors.white, BlendMode.srcATop),
                                    child: Image.asset("assets/YRL_red.png")),
                              )),
                          Padding(
                              padding: EdgeInsets.only(bottom: 45),
                              child: Container(
                                // color: Colors.yellow,
                                height: 270,
                                width: 373,
                              )),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Container(
                                height: 115,
                                width: 115,
                                child: ElevatedButton(
                                  onPressed: _togglePlayPause,
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(115, 115),
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent),
                                  child: Image.asset(
                                      isPlaying
                                          ? 'assets/PauseButtonImage.png'
                                          : 'assets/PlayButtonImage.png',
                                      fit: BoxFit.cover),
                                )),
                          ),
                          Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Container(
                                  height: 33,
                                  width: 250,
                                  child: FittedBox(
                                    child: Text(
                                      _songTitle.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))),
                          Container(
                              height: 25,
                              width: 100,
                              child: FittedBox(
                                child: Text(_artist.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey)),
                              ))
                        ]),
                  )),
            ],
          )),
    );
  }
}
