import 'package:flutter/material.dart';
import '/widgets/audio_list_tile.dart';
import 'package:provider/provider.dart';
import '/providers/audio_provider.dart';

class MusicPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Music Player')),
      // backgroundColor: Colors.blueGrey,
      body: Consumer<AudioProvider>(
        builder: (context, audioProvider, child) {
          return ListView.separated(
            itemCount: audioProvider.playlist.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return AudioListTile(
                  audio: audioProvider.playlist[index], index: index);
            },
          );
        },
      ),
    );
  }
}
