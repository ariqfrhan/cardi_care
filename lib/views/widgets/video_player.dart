import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final String videoPath;

  const VideoPlayer({super.key, required this.videoPath});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late CustomVideoPlayerController _customVideoPlayerController;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer(widget.videoPath);
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    return CustomVideoPlayer(
        customVideoPlayerController: _customVideoPlayerController);
  }

  void initializeVideoPlayer(String videoPath) {
    print("Video path: $videoPath");
    try {
      CachedVideoPlayerController _videoPlayerController;

      _videoPlayerController = CachedVideoPlayerController.asset(videoPath)
        ..initialize().then((_) {
          setState(() {});
        }).catchError((error) {
          setState(() {
            _errorMessage = "Error initializing video: ${error.toString()}";
          });
        });

      _customVideoPlayerController = CustomVideoPlayerController(
          context: context, videoPlayerController: _videoPlayerController);
    } catch (e) {
      setState(() {
        _errorMessage = "Unexpected error: ${e.toString()}";
      });
    }
  }
}
