import 'package:flutter/material.dart';
import 'dart:async';

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

  @override
  void initState() {
    super.initState();
    _startMovingSkull();
  }

  void _startMovingSkull() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _skullPositionX = _skullPositionX == 50 ? 200 : 50;
        _skullPositionY = _skullPositionY == 50 ? 300 : 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find the Spooky Item!'),
      ),
      body: Stack(
        children: [
          
          Positioned.fill(
            child: Image.asset(
              'assets/images/ghosts.png',  // Background image
              fit: BoxFit.cover,
            ),
          ),
          
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            left: _skullPositionX,
            top: _skullPositionY,
            child: GestureDetector(
              onTap: () {
                // Action when skull is clicked
                _showSpookyReaction('Creepy Skull');
              },
              child: Image.asset(
                'assets/images/creepy skull.jpg',
                width: 100,
              ),
            ),
          ),
          
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Action when pumpkin is clicked
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
