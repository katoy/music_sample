import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/audio_provider.dart';

class PlayerControls extends StatelessWidget {
  final int index;

  PlayerControls({required this.index});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    return StreamBuilder<Duration>(
      stream: audioProvider.currentPositionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final playing = audioProvider.isPlaying;
        final current = audioProvider.currentAudio;

        return IconButton(
          icon: Icon(playing && current == audioProvider.playlist[index]
              ? Icons.pause
              : Icons.play_arrow),
          onPressed: () => audioProvider.playAudio(index),
        );
      },
    );
  }
}
