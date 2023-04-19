class AudioFile {
  final String title;
  final String artist;
  final String album;
  final String audioUrl;
  final String imageUrl;
  final Duration startPosition;

  AudioFile({
    required this.title,
    required this.artist,
    required this.album,
    required this.audioUrl,
    required this.imageUrl,
    required this.startPosition,
  });
}
