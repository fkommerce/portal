import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import '../../../config/constants.dart';
import '../../../utils/logger/logger_helper.dart';

Future<PlatformFile?> pickFile([List<String>? allowedExtensions]) async {
  try {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      dialogTitle: appName,
      allowedExtensions:
          allowedExtensions ?? ['jpg', 'jpeg', 'png', 'pdf', 'docx', 'doc'],
    );
    if (file == null) return null;
    return file.files.single;
  } on PlatformException catch (e) {
    log.e('No File found. Error: $e');
    return null;
  }
}
