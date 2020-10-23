import 'package:epicture/models/image.dart';
import 'package:epicture/widgets/video/video_preview.dart';
import 'package:flutter/material.dart';

class ImagePreviewWidget extends StatelessWidget {
  final ImageModel image;

  ImagePreviewWidget({
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    if (image.type.contains("video")) {
      return VideoPreviewWidget(image: image);
    }

    return Image.network(
      image.url,
      fit: BoxFit.cover,
      loadingBuilder: _loading,
    );
  }

  Widget _loading(_, image, loading) {
    if (loading == null) return image;

    return Center(child: CircularProgressIndicator());
  }
}
