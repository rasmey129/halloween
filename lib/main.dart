import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';


void main(){
  runApp(const HalloweenScreen());
}


class HalloweenScreen extends StatefulWidget {
  const HalloweenScreen({super.key});

  @override
  _HalloweenScreenState createState() => _HalloweenScreenState();
}

class _HalloweenScreenState extends State<HalloweenScreen> {
  final AudioPlayer backgroundPlayer = AudioPlayer();
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    playBackgroundMusic();
  }

  Future<void> playBackgroundMusic() async {
    await backgroundPlayer.setAsset('assets/background.mp3');
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
       body: Stack(
        children: [
          SpookyCharacter(),
          InteractiveTrap(onTap: incrementCounter),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have tapped the trap this many times:',
                ),
                Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            )
          ),
        ],
      )
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

class InteractiveTrap extends StatelessWidget {
  final AudioPlayer trapPlayer = AudioPlayer();
  final VoidCallback onTap;

  InteractiveTrap({required this.onTap}) {
    trapPlayer.setAsset('assets/sounds/jumpscare.mp3');
  }

  @override 

   Widget build(BuildContext context) {
    return Positioned(
      top: 200,
      left: 100,
      child: GestureDetector(
        onTap: () {
          trapPlayer.seek(Duration.zero);
          trapPlayer.play();
          onTap(); 
        },
        child: Image.asset('assets/images/spooky_trap.png', width: 50),
      ),
    );
  }
}

class WinElement extends StatelessElement{
  final AudioPlayer victoryPlayer = AudioPlayer();
  final VoidCallback onTap;

  WinElement({required this.onTap}){
    victoryPlayer.setAsset('assets/sounds/victory.mp3');
  }
}