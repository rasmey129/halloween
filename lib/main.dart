import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: HalloweenScreen(),
  ));
}

class HalloweenApp extends StatelessWidget {
  const HalloweenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halloween Interactive Experience',
      theme: ThemeData.dark(),
      home: const HalloweenScreen(),
    );
  }
}

class HalloweenScreen extends StatefulWidget {
  const HalloweenScreen({super.key});

  @override
  _HalloweenScreenState createState() => _HalloweenScreenState();
}

class _HalloweenScreenState extends State<HalloweenScreen>
    with SingleTickerProviderStateMixin {
  final AudioPlayer backgroundPlayer = AudioPlayer();

  late AnimationController _controller;
  final Random random = Random();

  double ghostTop = 0;
  double ghostLeft = 0;
  double trapTop = 200;
  double trapLeft = 100;
  double pumpkinTop = 300;
  double pumpkinLeft = 200;

  int frameSkip = 0;

  @override
  void initState() {
    super.initState();
    playBackgroundMusic();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _controller.addListener(() {
      frameSkip++;
      if (frameSkip % 30 == 0) {
        setState(() {
          ghostTop = random.nextDouble() * 300;
          ghostLeft = random.nextDouble() * 300;

          trapTop = random.nextDouble() * 400;
          trapLeft = random.nextDouble() * 200;

          pumpkinTop = random.nextDouble() * 500;
          pumpkinLeft = random.nextDouble() * 300;
        });
        frameSkip = 0;
      }
    });
  }

  Future<void> playBackgroundMusic() async {
    await backgroundPlayer.setAsset('assets/background.mp3');
    backgroundPlayer.setLoopMode(LoopMode.one);
    backgroundPlayer.play();
  }

  @override
  void dispose() {
    backgroundPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halloween'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/appbackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: ghostTop,
            left: ghostLeft,
            child: const SpookyCharacter(),
          ),
          Positioned(
            top: trapTop,
            left: trapLeft,
            child: InteractiveTrap(onTap: () {}),
          ),
          Positioned(
            top: pumpkinTop,
            left: pumpkinLeft,
            child: Winning(onTap: () {}),
          ),
        ],
      ),
    );
  }
}

class SpookyCharacter extends StatelessWidget {
  const SpookyCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/ghost.png', width: 50);
  }
}

class InteractiveTrap extends StatelessWidget {
  final AudioPlayer trapPlayer = AudioPlayer();
  final VoidCallback onTap;

  InteractiveTrap({required this.onTap}) {
    trapPlayer.setAsset('assets/jumpscare.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        trapPlayer.seek(Duration.zero);
        trapPlayer.play();
        onTap();
      },
      child: Image.asset('assets/tree.png', width: 50),
    );
  }
}

class Winning extends StatelessWidget {
  final AudioPlayer victoryPlayer = AudioPlayer();
  final VoidCallback onTap;

  Winning({required this.onTap}) {
    victoryPlayer.setAsset('assets/victory.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        victoryPlayer.seek(Duration.zero);
        victoryPlayer.play();
        onTap();
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("You found the winning element"),
            content: const Text("Congratulations!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
      child: Image.asset('assets/pumpkin.png', width: 50),
    );
  }
}
