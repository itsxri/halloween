import 'package:flutter/material.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(TheScariestGameEver());
}

class TheScariestGameEver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Scariest Game Ever',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _skullPositionX = 50;
  double _skullPositionY = 50;
  final player = AudioPlayer();  // Audio player instance

  @override
  void initState() {
    super.initState();
    _startMovingSkull();
    _playBackgroundMusic();  // Start playing background music
  }

  void _startMovingSkull() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _skullPositionX = _skullPositionX == 50 ? 200 : 50;
        _skullPositionY = _skullPositionY == 50 ? 300 : 50;
      });
    });
  }

  void _playBackgroundMusic() async {
    await player.setAsset('assets/images/[Free] _Spooky_ _ Halloween Drill Type Beat [ ezmp3.cc ].mp3');  // audio
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find the Spooky Item!'),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/creepy background.jpg',  // Background image
              fit: BoxFit.cover,
            ),
          ),
          // Animated Creepy Skull
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            left: _skullPositionX,
            top: _skullPositionY,
            child: GestureDetector(
              onTap: () {
                _showSpookyReaction('Creepy Skull');
              },
              child: Image.asset(
                'assets/images/creepy skull.jpg',  // Skull image
                width: 100,
              ),
            ),
          ),
          // Pumpkin Image
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                _showSpookyReaction('Pumpkin');
              },
              child: Image.asset(
                'assets/images/pumpkin.png',
                width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSpookyReaction(String item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Spooky!'),
          content: Text('You clicked on the $item!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
