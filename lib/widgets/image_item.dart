import 'package:flutter/material.dart';

import '../constants.dart';

class ImageItem extends StatelessWidget {
  final String imageUrl;

  const ImageItem({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 50,
          left: 50,
          child: SizedBox(
            width: imageSize,
            height: imageSize,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
