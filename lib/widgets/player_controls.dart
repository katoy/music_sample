import 'package:flutter/material.dart';
import '/models/audio_file.dart';
import '/providers/audio_provider.dart';
import 'package:provider/provider.dart';

class PlayerControls extends StatelessWidget {
  PlayerControls();

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final currentIndex = audioProvider.currentIndex;
    final audioFile = audioProvider.audioFile(currentIndex);

    return StreamBuilder(
      stream: audioProvider.currentPositionStream,
      builder: (context, AsyncSnapshot<Duration> snapshotPosition) {
        final position = snapshotPosition.data ?? Duration.zero;
        final playing = audioProvider.playing;

        return StreamBuilder(
          stream: audioProvider.durationStream,
          builder: (context, AsyncSnapshot<Duration?> snapshotDuration) {
            final duration = snapshotDuration.data ?? Duration.zero;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8),
                if (audioFile != null)
                  SizedBox(
                    height: 10.0, // プログレスバーの高さ（太さ）を設定
                    child: LinearProgressIndicator(
                      value: duration.inMilliseconds == 0
                          ? 0
                          : (position - audioFile.startPosition)
                                  .inMilliseconds /
                              (duration - audioFile.startPosition)
                                  .inMilliseconds,
                    ),
                  ),
                SizedBox(height: 8),
                Text(
                  '${positionToString(position)} / ${positionToString(duration)}',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 8),
                Text(
                  '${audioProvider.currentIndex}: ${audioFile.title}',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String positionToString(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(position.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(position.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
