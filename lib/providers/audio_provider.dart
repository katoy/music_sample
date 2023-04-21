import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '/models/audio_file.dart';

class AudioProvider with ChangeNotifier {
  int _currentIndex = 0;
  bool _playing = false;
  AudioFile? _currentAudioFile;
  AudioFile audioFile(int index) {
    return _playlist[index];
  }

  // ここにプレイリストを追加してください
  static List<AudioFile> _playlist = [
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
      title: 'Song - 1',
      artist: 'SoundHelix',
      album: 'SoundHelix',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      imageUrl:
          'https://i1.sndcdn.com/avatars-000311378190-t4oy7m-t200x200.jpg',
      startPosition: Duration.zero,
    ),
    // AudioFile(
    //   title: 'Ambient Classical Guitar',
    //   artist: 'William King',
    //   album: 'Album 2',
    //   audioUrl: 'assets/audios/ambient-classical-guitar-144998.mp3',
    //   imageUrl:
    //       'https://cdn.pixabay.com/audio/2023/04/03/14-44-18-281_200x200.png',
    //   startPosition: Duration.zero,
    // ),
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  final StreamController<Duration> _currentPosition =
      StreamController<Duration>.broadcast();

  int get playlist_length => _playlist.length;
  int get currentIndex => _currentIndex;
  bool get playing => _playing;
  AudioFile? get currentAudioFile =>
      _currentIndex >= 0 ? _playlist[_currentIndex] : null;

  Stream<Duration> get currentPositionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  AudioProvider() {
    _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: _playlist
            .map((audio) => AudioSource.uri(Uri.parse(audio.audioUrl)))
            .toList(),
      ),
    );
    _initPositionStream();
  }

  void _initPositionStream() {
    _audioPlayer.positionStream.listen((position) {
      _currentPosition.add(position);
    });
  }

  void addAudioFile(AudioFile audio) {
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

  void disposeAudioPlayer() {
    _audioPlayer.dispose();
  }

  Future<void> play(int index) async {
    if (index >= 0) {
      _playing = true;
      _currentIndex = index;
      AudioFile audioFile = _playlist[index];
      _currentAudioFile = _playlist[index];
      await _audioPlayer.setUrl(audioFile.audioUrl);
      await _audioPlayer.seek(audioFile.startPosition);
      _audioPlayer.play();
    }
    notifyListeners();
  }

  Future<void> pause() async {
    _playing = false;
    _audioPlayer.pause();
    notifyListeners();
  }
}
