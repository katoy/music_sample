import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/widgets/audio_list_tile.dart';
import '/providers/audio_provider.dart';

class MusicPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player App'),
      ),
      body: ListView.builder(
        itemCount: audioProvider.playlist.length,
        itemBuilder: (context, index) {
          return AudioListTile(
              audio: audioProvider.playlist[index], index: index);
        },
      ),
    );
  }
}
