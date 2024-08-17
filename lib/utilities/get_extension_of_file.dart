import 'package:path/path.dart' as path;

String getExtensionOfFile(String filePath) {
  final extension = path.extension(filePath);
  return extension;
}