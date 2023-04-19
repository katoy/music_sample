import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/audio_provider.dart';

class PlayerControls extends StatelessWidget {
  final int index;

  PlayerControls({required this.index});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final audio = audioProvider.playlist[index];

    return StreamBuilder(
      stream: audioProvider.currentPositionStream,
      builder: (context, AsyncSnapshot<Duration> snapshotPosition) {
        final position = snapshotPosition.data ?? Duration.zero;
        final playing = audioProvider.isPlaying;
        final current = audioProvider.currentAudio;

        return StreamBuilder(
          stream: audioProvider.durationStream,
          builder: (context, AsyncSnapshot<Duration?> snapshotDuration) {
            final duration = snapshotDuration.data ?? Duration.zero;

            return Column(
              children: [
                IconButton(
                  icon: Icon(playing && current == audioProvider.playlist[index]
                      ? Icons.pause
                      : Icons.play_arrow),
                  onPressed: () => audioProvider.playAudio(index),
                ),
                SizedBox(height: 8),
                if (current == audio)
                  LinearProgressIndicator(
                    value: duration.inMilliseconds == 0
                        ? 0
                        : (position - audio.startPosition).inMilliseconds /
                            (duration - audio.startPosition).inMilliseconds,
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
