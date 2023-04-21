import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/audio_file.dart';
import '/providers/audio_provider.dart';

class AudioListTile extends StatelessWidget {
  final int index;

  const AudioListTile({required this.index});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final audioFile = audioProvider.audioFile(index);

    return Consumer<AudioProvider>(
      builder: (context, audioProvider, _) {
        final playing = audioProvider.playing;
        AudioFile? currentAudioFile = audioProvider.currentAudioFile;

        return ListTile(
          // ここで IconButton を SizedBox で囲む
          leading: SizedBox(
            width: 48, // 適切な幅を設定
            child: IconButton(
              onPressed: () async {
                if (currentAudioFile != audioFile || !playing) {
                  audioProvider.play(index);
                } else {
                  audioProvider.pause();
                }
              },
              icon: Icon(
                (currentAudioFile != audioFile || !playing)
                    ? Icons.play_arrow
                    : Icons.pause,
              ),
            ),
          ),
          title: Text(audioFile.title),
          subtitle: Text('${audioFile.artist} - ${audioFile.album}'),
        );
      },
    );
  }
}
