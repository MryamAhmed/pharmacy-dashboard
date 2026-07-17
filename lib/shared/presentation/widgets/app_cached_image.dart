// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// Project imports:
import 'app_image_placeholder.dart';
import 'app_loading_widget.dart';

/// Shared network image.
///
/// Per PR guidelines: every remote/network image in the app must use this
/// widget instead of a bare [Image.network] / [CachedNetworkImage].
///
/// Shows [AppLoadingWidget] while loading and [AppImagePlaceholder] when
/// [imageUrl] is null/empty or the image fails to load.
class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;

    final Widget image = (url == null || url.isEmpty)
        ? AppImagePlaceholder(width: width, height: height)
        : CachedNetworkImage(
            imageUrl: url,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, _) => SizedBox(
              width: width,
              height: height,
              child: const AppLoadingWidget(),
            ),
            errorWidget: (context, _, __) =>
                AppImagePlaceholder(width: width, height: height),
          );

    if (borderRadius == null) return image;
    return ClipRRect(borderRadius: borderRadius!, child: image);
  }
}
