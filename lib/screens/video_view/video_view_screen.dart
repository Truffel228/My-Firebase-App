import 'dart:io';

import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class VideoViewScreen extends StatefulWidget {
  const VideoViewScreen({Key? key}) : super(key: key);

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  late final VideoPlayerController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final videoFile = ModalRoute.of(context)!.settings.arguments as File;
    _controller = VideoPlayerController.file(videoFile)
      ..addListener(() => setState(() {}))
      ..initialize().then((_) => _controller.play());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: _controller.value.isInitialized
          ? Stack(
              children: [
                Center(
                  child: InteractiveViewer(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                height: 30,
                                child: Text(
                                  getVideoPosition(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AppColors.whiteColor,
                                      ),
                                ),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      if (_controller.value.isPlaying) {
                                        _controller.pause();
                                        return;
                                      }
                                      _controller.play();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        _controller.value.isPlaying
                                            ? FontAwesomeIcons.pause
                                            : FontAwesomeIcons.play,
                                        size: 16,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                            child: VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: VideoProgressColors(
                                  backgroundColor: AppColors.greyColor,
                                  bufferedColor: AppColors.whiteColor,
                                  playedColor: AppColors.purpleColor),
                              padding: const EdgeInsets.all(0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: LoadingWidget(),
            ),
    );
  }

  String getVideoPosition() {
    final mSec = _controller.value.position.inMilliseconds.round();
    final secs = (mSec / 1000).round();
    final min = (secs / 60).floor();
    final sec = secs.remainder(60);
    final minStr = min.toString().padLeft(2, '0');
    final secStr = sec.toString().padLeft(2, '0');
    return '$minStr:$secStr';
  }
}
