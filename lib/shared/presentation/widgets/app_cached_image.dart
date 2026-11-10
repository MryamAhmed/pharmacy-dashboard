// Dart imports:
import 'dart:typed_data';

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
///
/// Also accepts inline `data:image/...;base64,...` URIs (some API endpoints
/// embed the image instead of linking to it); those are decoded locally
/// because [CachedNetworkImage] can only fetch `http(s)` URLs.
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

  /// Decoded bytes per data URI, so each rebuild reuses the SAME
  /// [Uint8List]. `MemoryImage` compares bytes by identity — new bytes on
  /// every build made Flutter re-decode the whole image each time (a
  /// 1920×1920 pharmacy logo froze the screen on every tab tap).
  static final Map<String, Uint8List> _dataUriBytes = {};

  /// Upper bound for [_dataUriBytes] so it can't grow forever.
  static const int _maxCachedDataUris = 50;

  static Uint8List _bytesFor(String dataUri) {
    final cached = _dataUriBytes[dataUri];
    if (cached != null) return cached;
    if (_dataUriBytes.length >= _maxCachedDataUris) {
      // Drop the oldest entry (maps keep insertion order).
      _dataUriBytes.remove(_dataUriBytes.keys.first);
    }
    return _dataUriBytes[dataUri] = UriData.parse(dataUri).contentAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    // Decode at the size actually shown instead of the source size — a
    // 44px avatar doesn't need a 1920×1920 bitmap in memory.
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final cacheWidth = width == null ? null : (width! * pixelRatio).round();

    final Widget image = (url == null || url.isEmpty)
        ? AppImagePlaceholder(width: width, height: height)
        // Inline image: decode the base64 payload instead of fetching it.
        : url.startsWith('data:')
        ? Image.memory(
            _bytesFor(url),
            width: width,
            height: height,
            fit: fit,
            cacheWidth: cacheWidth,
            gaplessPlayback: true,
            errorBuilder: (context, _, __) =>
                AppImagePlaceholder(width: width, height: height),
          )
        : CachedNetworkImage(
            imageUrl: url,
            width: width,
            height: height,
            fit: fit,
            memCacheWidth: cacheWidth,
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
