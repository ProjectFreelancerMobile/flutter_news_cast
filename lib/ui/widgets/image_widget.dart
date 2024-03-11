import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:photo_view/photo_view.dart';

import '../../../res/theme/theme_service.dart';
import '../../utils/image_cache_manager.dart';
import 'shimmers/image_shimmer.dart';

class RoundNetworkImage extends StatelessWidget {
  final String? url;
  final double height;
  final double width;
  final double? radius;
  final BoxFit? boxFit;
  final Color? strokeColor;
  final double? strokeWidth;
  final bool? showImageError;

  RoundNetworkImage({required this.width, required this.height, this.url, this.radius, this.boxFit, this.strokeColor, this.strokeWidth, this.showImageError = true});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        cacheManager: CustomCacheManager.instance,
        fadeInDuration: Duration(milliseconds: 300),
        fadeOutDuration: Duration(milliseconds: 500),
        imageUrl: url ?? '',
        imageBuilder: (context, imageProvider) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
            border: Border.all(color: strokeColor ?? Colors.transparent, width: strokeWidth ?? 0),
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit ?? BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => ImageShimmer(width: width, height: height),
        errorWidget: (context, url, error) => showImageError!
            ? Assets.images.imgDefault.image(width: width, height: height, fit: BoxFit.contain)
            : ImageShimmer(
                width: width,
                height: height,
                radius: radius ?? 0,
              ),
        memCacheWidth: width > 300 ? 300 : width.toInt(),
        memCacheHeight: height > 300 ? 300 : height.toInt(),
      ),
    );
  }
}

class RoundNetworkImageTopRadius extends StatelessWidget {
  final String? url;
  final double height;
  final double width;
  final double? radius;
  final Widget? errorHolder;
  final BoxFit? boxFit;
  final Color? strokeColor;
  final double? strokeWidth;

  RoundNetworkImageTopRadius({required this.width, required this.height, this.url, this.radius, this.errorHolder, this.boxFit, this.strokeColor, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(radius ?? 0), topRight: Radius.circular(radius ?? 0)),
      child: CachedNetworkImage(
        cacheManager: CustomCacheManager.instance,
        fadeInDuration: Duration(milliseconds: 300),
        fadeOutDuration: Duration(milliseconds: 500),
        imageUrl: url ?? '',
        imageBuilder: (context, imageProvider) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(radius ?? 0), topRight: Radius.circular(radius ?? 0)),
            border: Border.all(color: strokeColor ?? Colors.transparent, width: strokeWidth ?? 0),
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit ?? BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => ImageShimmer(width: width, height: height),
        errorWidget: (context, url, error) =>
            errorHolder ??
            ImageShimmer(
              width: width,
              height: height,
              radius: radius ?? 0,
            ),
        memCacheWidth: width > 300 ? 300 : width.toInt(),
        memCacheHeight: height > 300 ? 300 : height.toInt(),
      ),
    );
  }
}

class CircleNetworkImage extends AvatarNetworkImage {
  CircleNetworkImage({required double size, String? url, Widget? errorHolder, BoxFit? boxFit, Color? strokeColor, double? strokeWidth})
      : super(radius: size * 2 / 3, url: url, width: size, height: size, boxFit: boxFit, errorHolder: errorHolder, strokeWidth: strokeWidth, strokeColor: strokeColor);
}

class PhotoViewNetworkImage extends StatelessWidget {
  final String? url;
  final double height;
  final double width;
  final double? radius;
  final Widget? errorHolder;
  final dynamic placeholder;
  final BoxFit? boxFit;
  final Color? strokeColor;
  final double? strokeWidth;

  PhotoViewNetworkImage(
      {required this.width, required this.height, this.url, this.radius = 0.0, this.placeholder, this.errorHolder, this.boxFit, this.strokeColor, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: SizedBox(
        width: width,
        height: height,
        child: PhotoView(
          minScale: PhotoViewComputedScale.covered,
          maxScale: PhotoViewComputedScale.covered,
          filterQuality: FilterQuality.high,
          initialScale: PhotoViewComputedScale.covered,
          imageProvider: CachedNetworkImageProvider(
            url ?? '',
          ),
          loadingBuilder: (context, event) => ImageShimmer(width: width, height: height),
        ),
      ),
    );
  }
}

class AvatarNetworkImage extends StatefulWidget {
  final String? url;
  final double height;
  final double width;
  final double? radius;
  final Widget? errorHolder;
  final BoxFit? boxFit;
  final Color? strokeColor;
  final double? strokeWidth;
  final String? userName;
  final TextStyle? textStyle;

  AvatarNetworkImage(
      {required this.width, required this.height, this.url, this.radius = 0.0, this.errorHolder, this.boxFit, this.strokeColor, this.strokeWidth, this.userName, this.textStyle});

  @override
  State<StatefulWidget> createState() => _AvatarNetworkImageState();
}

class _AvatarNetworkImageState extends State<AvatarNetworkImage> {
  String? url;

  @override
  void initState() {
    super.initState();
    url = widget.url;
  }

  @override
  void didUpdateWidget(covariant AvatarNetworkImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.url!.isNotEmpty) url = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius ?? 0),
      child: CachedNetworkImage(
        cacheManager: CustomCacheManager.instance,
        fadeInDuration: Duration(milliseconds: 300),
        fadeOutDuration: Duration(milliseconds: 500),
        imageUrl: url ?? '',
        imageBuilder: (context, imageProvider) => Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.all(Radius.circular(widget.radius!)),
            border: Border.all(color: widget.strokeColor ?? Colors.transparent, width: widget.strokeWidth ?? 0),
            image: DecorationImage(
              image: imageProvider,
              fit: widget.boxFit ?? BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => ImageShimmer(width: widget.width, height: widget.height),
        errorWidget: (context, url, error) => widget.errorHolder ?? _buildErrorWidget(widget.radius!),
        memCacheWidth: widget.width > 300 ? 300 : widget.width.toInt(),
        memCacheHeight: widget.height > 300 ? 300 : widget.height.toInt(),
      ),
    );
  }

  Widget _buildErrorWidget(double radius) {
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          gradient: LinearGradient(begin: Alignment(1, 0), end: Alignment(0, 1), colors: [
            getColor().themeColorPrimary,
            getColor().themeColorPrimary.withOpacity(0.5),
          ])),
      child: Text(
        getUserName(),
        style: widget.textStyle ?? text24.bold.textColorWhite,
      ),
    );
  }

  String getUserName() {
    if (widget.userName == null || widget.userName!.isEmpty) return "";
    final arrName = widget.userName!.split(" ");
    return arrName.isNotEmpty ? arrName[arrName.length - 1][0].toUpperCase() : "";
  }
}
