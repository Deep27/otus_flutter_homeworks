import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  ImageHeader(this.imagePath);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(imagePath),
        const Positioned(
          child: const Padding(
            padding: const EdgeInsets.all(24.0),
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        const Positioned(
          right: 0,
          child: const Padding(
            padding: const EdgeInsets.all(24.0),
            child: const Icon(
              Icons.open_in_new,
            ),
          ),
        ),
      ],
    );
  }
}
