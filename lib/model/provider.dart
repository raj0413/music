import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Music {
  final String albumImage;
  final String albumPath;
  final String albumName;
  final String albumArtist;

  Music({
    required this.albumImage,
    required this.albumPath,
    required this.albumName,
    required this.albumArtist,
  });
}

class MusicProvider extends ChangeNotifier {
  List<Music> musicList = [
    Music(
      albumImage: 'assets/images/music1.jpg',
      albumPath: 'audio/headlights.mp3',
      albumName: 'feat.KIDDO - HEADLIGHTS',
      albumArtist: 'Alan walker',
    ),
    Music(
      albumImage: 'assets/images/music2.jpg',
      albumPath: 'audio/IndiaKiHeartbeat.mp3',
      albumName: 'India ki Heartbeat',
      albumArtist: 'Battlegrounds Mobile India',
    ),
    Music(
      albumImage: 'assets/images/music3.jpg',
      albumPath: 'audio/SoundofSalaar.mp3',
      albumName: 'Sound Of Salaar',
      albumArtist: 'Hombale Films',
    ),
     Music(
      albumImage: 'assets/images/music4.jpg',
      albumPath: 'audio/YODHA_Tiranga.mp3',
      albumName: 'TIRANGA(Yodha movie)',
      albumArtist: 'T-Series',
    ),
    
    
  ];

  Music? _currentMusic;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;

  Music? get currentMusic => _currentMusic;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  bool get isPlaying => _isPlaying;

  void setCurrentMusic(Music music) {
    _currentMusic = music;
    _playMusic();
    notifyListeners();
  }

   void _playMusic() async {
    await _audioPlayer.play(AssetSource(_currentMusic!.albumPath));
    _isPlaying = true;

    _audioPlayer.onDurationChanged.listen((duration) {
      _totalDuration = duration;
      notifyListeners();
    });
    // Listen for position updates
    _audioPlayer.onPositionChanged.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    // Handle track completion
    _audioPlayer.onPlayerComplete.listen((_) {
      _isPlaying = false;
      _currentPosition = Duration.zero;
      notifyListeners();
    });
  }

  void togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void forward() {
    final newPosition = _currentPosition + Duration(seconds: 10);
    if (newPosition < _totalDuration) {
      seek(newPosition);
    } else {
      seek(_totalDuration);
    }
  }

  void backward() {
    final newPosition = _currentPosition - Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      seek(newPosition);
    } else {
      seek(Duration.zero);
    }
  }
}
