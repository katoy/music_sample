import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '/models/audio_file.dart';

class AudioProvider with ChangeNotifier {
  // ここにプレイリストを追加してください
  List<AudioFile> _playlist = [
    AudioFile(
      title: 'Carefree',
      artist: 'Kevin MacLeod',
      album: 'Album 1',
      audioUrl:
          'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
      imageUrl:
          'https://pbs.twimg.com/profile_images/21278082/fish_400x400.jpg',
      startPosition: Duration.zero,
    ),
    AudioFile(
      title: 'Ambient Classical Guitar',
      artist: 'William King',
      album: 'Album 2',
      audioUrl: 'assets/audios/ambient-classical-guitar-144998.mp3',
      imageUrl:
          'https://cdn.pixabay.com/audio/2023/04/03/14-44-18-281_200x200.png',
      startPosition: Duration.zero,
    ),
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  List<AudioFile> get playlist => _playlist;
  bool get isPlaying => _audioPlayer.playing;
  AudioFile? get currentAudio => _audioPlayer.currentIndex != null
      ? _playlist[_audioPlayer.currentIndex!]
      : null;
  Stream<Duration> get currentPositionStream => _audioPlayer.positionStream;

  AudioProvider() {
    _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: _playlist
            .map((audio) => AudioSource.uri(Uri.parse(audio.audioUrl)))
            .toList(),
      ),
    );
  }

  void addAudio(AudioFile audio) {
    _playlist.add(audio);
    _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: _playlist
            .map((audio) => AudioSource.uri(Uri.parse(audio.audioUrl)))
            .toList(),
      ),
    );
    notifyListeners();
  }

  void playAudio(int index) async {
    if (_audioPlayer.currentIndex == index) {
      if (!_audioPlayer.playing) {
        await _audioPlayer.seek(_playlist[index].startPosition);
        await _audioPlayer.play();
      } else {
        await _audioPlayer.pause();
      }
    } else {
      await _audioPlayer.seek(_playlist[index].startPosition, index: index);
      await _audioPlayer.play();
    }
    notifyListeners();
  }

  void disposeAudioPlayer() {
    _audioPlayer.dispose();
  }
}
