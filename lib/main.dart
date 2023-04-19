import 'package:flutter/material.dart';
import '/providers/audio_provider.dart';
import '/screens/music_player_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AudioProvider(),
      child: MaterialApp(
        title: 'Flutter Music Player',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MusicPlayerScreen(),
      ),
    );
  }
}
