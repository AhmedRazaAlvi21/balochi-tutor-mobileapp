import 'package:file_picker/file_picker.dart';

Future filepicker({FileType? type, List<String>? extensions}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: type ?? FileType.image,
    allowedExtensions: extensions,
    allowMultiple: false,
  );
  if (result != null) {
    return result.files.single.path.toString();
  } else {
    return '';
  }
}
