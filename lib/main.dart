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
  final backgroundPlayer = AudioPlayer();  // For background music
  final soundEffectPlayer = AudioPlayer(); // For sound effects (correct and scream)

  @override
  void initState() {
    super.initState();
    _startMovingSkull();
    _playBackgroundMusic();  // Start background music
  }

  void _startMovingSkull() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _skullPositionX = _skullPositionX == 50 ? 200 : 50;
        _skullPositionY = _skullPositionY == 50 ? 300 : 50;
      });
    });
  }

  // Play the background music
  void _playBackgroundMusic() async {
    await backgroundPlayer.setAsset('assets/images/[Free] _Spooky_ _ Halloween Drill Type Beat [ ezmp3.cc ].mp3');
    backgroundPlayer.play();
  }

  // Stop the background music
  void _stopBackgroundMusic() {
    backgroundPlayer.stop();
  }

  // Play the scream sound effect for the wrong choice
  void _playScreamSound() async {
    _stopBackgroundMusic();  // Stop the background music
    await soundEffectPlayer.setAsset('assets/images/Scary Scream - Sound Effects (HD) [ ezmp3.cc ].mp3');
    soundEffectPlayer.play();
  }

  // Play success sound for the correct choice
  void _playCorrectSound() async {
    _stopBackgroundMusic();  // Stop the background music
    await soundEffectPlayer.setAsset('assets/images/Correct Sound Effect [ ezmp3.cc ].mp3');
    soundEffectPlayer.play();
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
          // Animated Creepy Skull (trap)
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            left: _skullPositionX,
            top: _skullPositionY,
            child: GestureDetector(
              onTap: () {
                // Play scream sound for wrong pick
                _playScreamSound();
                _showSpookyReaction('Creepy Skull');
              },
              child: Image.asset(
                'assets/images/creepy skull.jpg',  // Skull image
                width: 100,
              ),
            ),
          ),
          // Static Pumpkin Image (correct item)
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Play correct sound for right pick
                _playCorrectSound();
                _showWinningMessage();
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

  void _showWinningMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You found the correct item!'),
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
