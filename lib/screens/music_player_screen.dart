import 'package:flutter/material.dart';
import '/providers/audio_provider.dart';
import '/widgets/audio_list_tile.dart';
import '/widgets/player_controls.dart';
import 'package:provider/provider.dart';

class MusicPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Music Player')),
      // backgroundColor: Colors.blueGrey,
      body: Consumer<AudioProvider>(
        builder: (context, audioProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: audioProvider.playlist_length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    return AudioListTile(index: index);
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: PlayerControls(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
