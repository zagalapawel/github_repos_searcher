import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage({
    required this.imageUrl,
    this.width,
    this.height,
    super.key,
  });

  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: width,
      height: height,
      errorWidget: (context, _, __) => _CachedNetworkImageErrorWidget(
        width: width,
        height: height,
      ),
    );
  }
}

class _CachedNetworkImageErrorWidget extends StatelessWidget {
  const _CachedNetworkImageErrorWidget({
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  static const _errorIconSize = 24.0;

  @override
  Widget build(BuildContext context) {
    final iconSize = height != null ? height! / 3 : _errorIconSize;
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          color: Colors.deepOrange,
          child: Center(
            child: Icon(
              Icons.no_photography_sharp,
              size: iconSize,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
