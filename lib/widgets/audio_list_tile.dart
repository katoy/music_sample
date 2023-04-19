import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/audio_file.dart';
import '/providers/audio_provider.dart';
import 'player_controls.dart';

class AudioListTile extends StatelessWidget {
  final AudioFile audio;
  final int index;

  AudioListTile({required this.audio, required this.index});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    return ListTile(
      leading: PlayerControls(index: index),
      title: Text(audio.title),
      subtitle: Text('${audio.artist} - ${audio.album}'),
      onTap: () => audioProvider.playAudio(index),
    );
  }
}
