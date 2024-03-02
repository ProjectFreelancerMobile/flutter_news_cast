import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../res/theme/theme_service.dart';

class ImageShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  ImageShimmer({required this.width, required this.height, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Shimmer.fromColors(
            baseColor: getColor().themeColorB2B2B2.withOpacity(0.4),
            highlightColor: getColor().themeColorB2B2B2.withOpacity(0.2),
            child: Container(
              width: width,
              height: height,
              color: getColor().themeColorB2B2B2,
            )));
  }
}
