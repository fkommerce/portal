import 'package:flutter/material.dart';

import '../../config/get_platform.dart';
import 'components/android_ios_image.dart';
import 'components/web_image.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(this.image, {super.key, this.isPlatformFile = false});

  final dynamic image;
  final bool isPlatformFile;

  @override
  Widget build(BuildContext context) {
    return pt.isMobile && !isPlatformFile
        ? AndroidIOSImage(image)
        : WebImage(image);
  }
}
