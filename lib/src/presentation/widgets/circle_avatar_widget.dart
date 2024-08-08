import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final ImageProvider? image;
  final Color? backgroundColor;
  final double borderWidth;
  final double radius;

  const CircleAvatarWidget({
    super.key,
    required this.image,
    required this.radius,
    TextStyle? textStyle,
    this.borderWidth = 1,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
            backgroundColor: backgroundColor,
            backgroundImage: image,
            radius: radius - borderWidth,
          );
  }
}
