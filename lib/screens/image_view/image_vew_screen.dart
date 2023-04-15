import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        ModalRoute.of(context)!.settings.arguments as String;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Material(
        color: Colors.black,
        child: InteractiveViewer(
          child: Hero(
            tag: 'tag',
            child: Image.network(
              imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
