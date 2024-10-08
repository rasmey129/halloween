import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';

class HalloweenScreen extends StatefulWidget {
  const HalloweenScreen({super.key});

  @override
  _HalloweenScreenState createState() => _HalloweenScreenState();
}

class _HalloweenScreenState extends State<HalloweenScreen> {
  final AudioPlayer backgroundPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playBackgroundMusic();
  }

  Future<void> playBackgroundMusic() async {
    await backgroundPlayer.setAsset('assets');
    backgroundPlayer.setLoopMode(LoopMode.one);
    backgroundPlayer.play();
  }

  @override
  void dispose() {
    backgroundPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halloween'),
      ),
      body: const Center(
        child: Text('Welcome to Halloween!'),
      ),
    );
  }
}

class SpookyCharacter extends StatefulWidget {
  @override
  SpookyCharacterState createState() => SpookyCharacterState();
}

class SpookyCharacterState extends State<SpookyCharacter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double topPosition = 0;
  double leftPosition = 0;
  final random = Random();
   @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _controller.addListener(() {
      setState(() {
        topPosition = random.nextDouble() * 300;
        leftPosition = random.nextDouble() * 300;
      });
    });
   }

   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPosition,
      left: leftPosition,
      child: Image.asset('assets/images/ghost.png', width: 50),
    );
  }
}