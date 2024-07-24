import 'package:crop_your_image/crop_your_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/constants.dart';
import '../../../config/get_platform.dart';
import '../../../router/animation.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';

Future<Uint8List?> filePickFromDevice(
    BuildContext context, int imageQuality) async {
  try {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      dialogTitle: appName,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (file == null || file.files.isEmpty) return null;
    Uint8List bytes = pt.isWeb
        ? file.files.first.bytes!
        : await file.files.first.toFile.readAsBytes();
    if (!context.mounted) return bytes;
    final croppedFile = await fadePush(context, ImageCropScreen(bytes));
    return croppedFile ?? bytes;
  } on PlatformException catch (e) {
    log.e('No Image found. Error: $e');
    return null;
  }
}

/// Helper Widget for the cropping screen
class ImageCropScreen extends StatefulWidget {
  const ImageCropScreen(this.bytes, {super.key});
  final Uint8List bytes;

  @override
  State<ImageCropScreen> createState() => _ImageCropScreenState();
}

class _ImageCropScreenState extends State<ImageCropScreen> {
  final cntrlr = CropController();
  CropControllerDelegate delegate = CropControllerDelegate();

  @override
  void initState() {
    super.initState();
    delegate.onImageChanged = (_) {};
    delegate.onChangeAspectRatio = (_) {};
    cntrlr.delegate = delegate;
    cntrlr.image = widget.bytes;
    cntrlr.aspectRatio = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Crop Image'),
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: borderRadius12,
          child: SizedBox(
            height: 500,
            width: 500,
            child: Column(
              children: [
                Expanded(
                  child: Crop(
                    controller: cntrlr,
                    image: widget.bytes,
                    onCropped: (cf) => context.pop(cf),
                    maskColor: Colors.black.withOpacity(0.8),
                    initialSize: 0.8,
                    cornerDotBuilder: (size, edgeAlignment) =>
                        DotControl(color: context.theme.primaryColor),
                    clipBehavior: Clip.none,
                    interactive: true,
                    fixCropRect: true,
                    radius: 10,
                    progressIndicator: const CircularProgressIndicator(),
                  ),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: ElevatedButton(
                    onPressed: () => cntrlr.crop(),
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
