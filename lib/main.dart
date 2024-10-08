import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Halloween'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final AudioPlayer backgroundPlayer = AudioPlayer();

Future<void> playBackground() async{
  await backgroundPlayer.setAsset('assets');
  backgroundPlayer.setLoopMode(LoopMode.one);
    backgroundPlayer.play();
}

void initialState(){
  super.initState();
  playBackground();
}

void dispose(){
  backgroundPlayer.dispose();
  super.dispose();
}

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halloween Interactive Experience'),
      ),
      body: const Center(
        child: Text('Welcome to Halloween!'),
      ),
    );
  }
}
