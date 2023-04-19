import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/audio_file.dart';
import '/providers/audio_provider.dart';

class AudioListTile extends StatelessWidget {
  final AudioFile audio;
  final int index;

  AudioListTile({required this.audio, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, _) {
        final playing = audioProvider.playing;
        final current = audioProvider.current;

        return ListTile(
          // ここで IconButton を SizedBox で囲む
          leading: SizedBox(
            width: 48, // 適切な幅を設定
            child: IconButton(
              onPressed: () {
                if (playing && current == audio) {
                  audioProvider.pause();
                } else {
                  audioProvider.play(audio, index);
                }
              },
              icon: Icon(
                  playing && current == audio ? Icons.pause : Icons.play_arrow),
            ),
          ),
          title: Text(audio.title),
          subtitle: Text('${audio.artist} - ${audio.album}'),
        );
      },
    );
  }
}
