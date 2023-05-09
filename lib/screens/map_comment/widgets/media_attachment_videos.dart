import 'dart:io';

import 'package:fire_base_app/shared/entities/entities.dart';
import 'package:fire_base_app/shared/router.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MedialAttachmentVideos extends StatelessWidget {
  const MedialAttachmentVideos({
    Key? key,
    required this.videos,
  }) : super(key: key);

  final List<MediaAttachment> videos;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];

          return InkWell(
            onTap: () => _onVideoTap(context, videos[index].file),
            child: Hero(
              tag: 'tag',
              child: Container(
                width: 80,
                height: 80,
                margin: EdgeInsets.only(
                  left: index == 0 ? 16 : 8,
                  right: index == videos.length - 1 ? 16 : 0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(14),
                  image: video.videoPreview != null
                      ? DecorationImage(
                          image: FileImage(video.videoPreview!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: video.videoDurationSec != null
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: VideoDurationChip(
                            durationSec: video.videoDurationSec!,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onVideoTap(BuildContext context, File? videoFile) {
    if (videoFile == null) {
      return;
    }
    Navigator.of(context).pushNamed(
      Routes.videoView,
      arguments: videoFile,
    );
  }
}
