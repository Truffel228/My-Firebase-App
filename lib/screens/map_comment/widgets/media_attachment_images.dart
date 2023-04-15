import 'package:fire_base_app/shared/entities/entities.dart';
import 'package:fire_base_app/shared/router.dart';
import 'package:flutter/material.dart';

class MedialAttachmentImages extends StatelessWidget {
  const MedialAttachmentImages({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<MediaAttachment> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => _onImageTap(context, images[index].fileUrl),
          child: Hero(
            tag: 'tag',
            child: Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.only(
                left: index == 0 ? 16 : 8,
                right: index == images.length - 1 ? 16 : 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image: DecorationImage(
                  image: NetworkImage(images[index].fileUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onImageTap(BuildContext context, String imageUrl) =>
      Navigator.of(context).pushNamed(
        Routes.imageView,
        arguments: imageUrl,
      );
}
