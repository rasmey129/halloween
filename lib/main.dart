import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
