import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDiscoverCard extends StatefulWidget {
  final String videoUrl;
  final String title;

  const VideoDiscoverCard({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  @override
  State<VideoDiscoverCard> createState() => _VideoDiscoverCardState();
}

class _VideoDiscoverCardState extends State<VideoDiscoverCard> {
  late VideoPlayerController _controller;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then((_) {
        setState(() {
          isReady = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF2C2C2C),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            // ================= VIDEO =================
            isReady
                ? VideoPlayer(_controller)
                : Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

            // ================= GRADIENT =================
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            // ================= TITLE =================
            Positioned(
              left: 16,
              bottom: 16,
              right: 16,
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // ================= PLAY BUTTON =================
            Center(
              child: IconButton(
                iconSize: 54,
                color: Colors.white,
                icon: Icon(
                  _controller.value.isPlaying
                      ? Icons.pause_circle
                      : Icons.play_circle,
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
